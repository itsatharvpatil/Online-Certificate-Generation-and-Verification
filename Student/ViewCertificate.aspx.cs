using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_ViewCertificate : System.Web.UI.Page
{

    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string ParticipationID;
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    ReportDocument rprt = new ReportDocument();  

    protected void Page_Load(object sender, EventArgs e)
    {
        ParticipationID = Request.QueryString["ParticipationID"].ToString();
        try
        {

            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_GetCrystalReportName", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iParticipationID", ParticipationID);
            DataTable dt = new DataTable();
            da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                string CrystalReport = dt.Rows[0]["CrystalReport"].ToString();
                rprt.Load(Server.MapPath(CrystalReport));
                rprt.SetDatabaseLogon("sa", "root", "PROJECTIDEAS", "event_db");
                //con = new SqlConnection(constr);
                //cmd = new SqlCommand("usp_generate_certificate", con);
                //cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.AddWithValue("@iParticipationID", ParticipationID);
                //DataTable dt = new DataTable();
                //da = new SqlDataAdapter(cmd);
                //da.Fill(dt);

                //rprt.SetDataSource(dt);

                rprt.SetParameterValue("@iParticipationID", Convert.ToInt32(ParticipationID));
                Stream oStream = null;
                byte[] byteArray = null;
                oStream = rprt.ExportToStream(ExportFormatType.PortableDocFormat);
                byteArray = new byte[oStream.Length];
                oStream.Read(byteArray, 0, Convert.ToInt32((long)(oStream.Length - 1L)));
                base.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + ParticipationID.ToString() + "\"");
                base.Response.ClearContent();
                base.Response.ClearHeaders();
                base.Response.ContentType = "application/pdf";
                base.Response.BinaryWrite(byteArray);
                base.Response.Flush();
                base.Response.Close();
                rprt.Close();
                rprt.Dispose();

                // rprt.SetParameterValue("@iParticipationID", ParticipationID);
                //CrystalReportViewer1.ReportSource = rprt;
                //rprt.Load(Server.MapPath("CrystalReport2.rpt"));
                //rprt.SetParameterValue("@iParticipationID", ParticipationID);
                //CrystalReportViewer1.ReportSource = rprt;
            }
            else
            {
                Response.Write("<script>alert('Something went wrong')</script>");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}