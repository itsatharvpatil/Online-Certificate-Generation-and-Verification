using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Mentor_Profile : System.Web.UI.Page
{

    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    int m_id;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["id"] == null)
            Response.Redirect("../Login.aspx");
        else
            m_id = Convert.ToInt32(Session["id"]);

        fillRepeater();

    }

   
    protected void rptCourse_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string command = e.CommandName.ToString();
        int c_id = Convert.ToInt32(e.CommandArgument);

        try
        {
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();

            cmd = new SqlCommand("update mentor_master set c_id=@cid where m_id=@mid", con);
            cmd.Parameters.AddWithValue("@mid", m_id);
            cmd.Parameters.AddWithValue("@cid", c_id);
            int result = (int)cmd.ExecuteNonQuery();
            if(result == 1)
                Response.Write("<script>alert('Course Selected')</script>");
            else
                Response.Write("<script>alert('Something went wrong')</script>");
            con.Close();
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }


    void fillRepeater()
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_mstEvent_upcoming", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rptCourse.DataSource = dt;
                rptCourse.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}