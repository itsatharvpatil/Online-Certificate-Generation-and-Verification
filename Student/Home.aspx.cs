using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Home : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string p_id;
    string StudentID;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StudentID"] == null)
            Response.Redirect("../Login.aspx");

        //u_id = Session["u_id"].ToString();
        StudentID = Session["StudentID"].ToString();
        fillEventDataList(StudentID);
    }

    private void fillEventDataList(string StudentID)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_mstEvent_upcoming", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iStudentID", Convert.ToInt32(StudentID));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rptEvents.DataSource = dt;
                rptEvents.DataBind();
            }
            else
            {
                rptEvents.DataSource = null;
                rptEvents.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string command = e.CommandName.ToString();
        int EventID = Convert.ToInt32(e.CommandArgument);

        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_save_trnParticipation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iParticipationID",0);
            cmd.Parameters.AddWithValue("@iStudentID", Convert.ToInt32(StudentID));
            cmd.Parameters.AddWithValue("@iEventID", EventID);
            cmd.Parameters.AddWithValue("@iApproveRejectTypeID", 1);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                string message = dt.Rows[0]["Message"].ToString();
                Response.Write("<script>alert('" + message + "')</script>");
            }
            else
            {
                Response.Write("<script>alert('Something went wrong')</script>");
            }
            //con.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}