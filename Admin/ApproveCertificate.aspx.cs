using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ApproveCertificate : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            fillGridView();
    }

    private void fillGridView()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_trnParticipation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iLoginUserID", 0);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvApprove.DataSource = dt;
                gvApprove.DataBind();

                //for (int i = 0; i < dt.Rows.Count; i++) 
                //{
                //    if (gvApprove.Rows[i].Cells[1].Text == "NA")
                //    {
                //        Button btnVal = (Button)e.Row.FindControl("buttonSubmit");
                //        btnVal.Enabled = false;

                //    }
                //}
            }
            else
            {
                gvApprove.DataSource = null;
                gvApprove.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void gvApprove_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int ParticipationID = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName == "ApproveTable")
            updateStatus(ParticipationID, 2);
        else
            updateStatus(ParticipationID,3);
    }

    private void updateStatus(int ParticipationID, int Status)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_save_trnParticipation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iParticipationID", ParticipationID);
            cmd.Parameters.AddWithValue("@iStudentID",0);
            cmd.Parameters.AddWithValue("@iEventID", 0);
            cmd.Parameters.AddWithValue("@iApproveRejectTypeID", Status);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                string message = dt.Rows[0]["Message"].ToString();
                Response.Write("<script>alert('" + message + "')</script>");
                fillGridView();
            }
            else
            {
                Response.Write("<script>alert('Something went wrong')</script>");
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }
}