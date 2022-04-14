using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageStudent : System.Web.UI.Page
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
            cmd = new SqlCommand("usp_select_mstStudent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iStudentID", 0);
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvStudent.DataSource = dt;
                gvStudent.DataBind();
            }
            else
            {
                gvStudent.DataSource = null;
                gvStudent.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void gvStudent_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string s_id = e.CommandArgument.ToString();
        if (e.CommandName == "EditTable")
            Response.Redirect("AddStudent.aspx?action=edit&id=" + s_id);
        else
            deleteStudent(s_id);
    }

    private void deleteStudent(string s_id)
    {
        try
        {
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();
            cmd = new SqlCommand("delete from mstStudent where StudentID = @StudentID", con);
            cmd.Parameters.AddWithValue("@StudentID", Convert.ToInt32(s_id));
            int result = cmd.ExecuteNonQuery();
            if (result == 1)
                fillGridView();
            else
                Response.Write("<script>alert('Something went wrong')</script>");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}