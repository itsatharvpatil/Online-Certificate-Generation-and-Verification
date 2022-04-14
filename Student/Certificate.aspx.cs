using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Certificate : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string StudentID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StudentID"] == null)
            Response.Redirect("../Login.aspx");

        //u_id = Session["u_id"].ToString();
        StudentID = Session["StudentID"].ToString();

        if (!IsPostBack)
            fillGridView(StudentID);
    }

    private void fillGridView(string StudentID)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_trnParticipation", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iLoginUserID", Convert.ToInt32(StudentID));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvEvent.DataSource = dt;
                gvEvent.DataBind();
            }
            else
            {
                gvEvent.DataSource = null;
                gvEvent.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void gvEvent_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string ParticipationID = e.CommandArgument.ToString();
        Response.Redirect("ViewCertificate.aspx?ParticipationID=" + ParticipationID);
    }
    protected void gvEvent_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       // Button button = (Button)e.Row.FindControl("btnGenerate");

        //Button button = (Button)e.Row.Cells[9].FindControl("btnGenerate");
        //if (e.Row.Cells[8].Text == "Approved")
        //{
        //    button.Enabled = true;
        //}
        //else
        //    button.Enabled = false;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button button = (Button)e.Row.FindControl("btnGenerate");
            if (e.Row.Cells[8].Text == "Approved")
            {
                button.Enabled = true;
            }
            else
                button.Enabled = false;
        }
    }
}