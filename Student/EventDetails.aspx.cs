using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_EventDetails : System.Web.UI.Page
{

    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    int StudentID;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["StudentID"] == null)
            Response.Redirect("../Login.aspx");
        else
            StudentID = Convert.ToInt32(Session["StudentID"]);

        fillRepeater();

    }


    protected void rptCourse_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string command = e.CommandName.ToString();
        int c_id = Convert.ToInt32(e.CommandArgument);

        //try
        //{
        //    con = new SqlConnection(constr);
        //    if (con.State != ConnectionState.Open)
        //        con.Open();

        //    cmd = new SqlCommand("update mentor_master set c_id=@cid where m_id=@mid", con);
        //    cmd.Parameters.AddWithValue("@mid", m_id);
        //    cmd.Parameters.AddWithValue("@cid", c_id);
        //    int result = (int)cmd.ExecuteNonQuery();
        //    if (result == 1)
        //        Response.Write("<script>alert('Course Selected')</script>");
        //    else
        //        Response.Write("<script>alert('Something went wrong')</script>");
        //    con.Close();
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }


    void fillRepeater()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_mstEvent_upcoming", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iStudentID", StudentID);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rptEvents.DataSource = dt;
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
            cmd.Parameters.AddWithValue("@iParticipationID", 0);
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

    static string Hash(string input)
    {
        var hash = new SHA1Managed().ComputeHash(Encoding.UTF8.GetBytes(input));
        return string.Concat(hash.Select(b => b.ToString("x2")));
    }
}