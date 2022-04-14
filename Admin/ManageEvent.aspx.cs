using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ManageEvent : System.Web.UI.Page
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
            cmd = new SqlCommand("usp_select_mstEvent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iEventID",0);
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
        string e_id = e.CommandArgument.ToString();
        if (e.CommandName == "EditTable")
            Response.Redirect("AddEvent.aspx?action=edit&id=" + e_id);
        else
            deleteEvent(e_id);
    }

    private void deleteEvent(string e_id)
    {
        try
        {
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();
            cmd = new SqlCommand("delete from mstEvent where EventID = @EventID", con);
            cmd.Parameters.AddWithValue("@EventID", Convert.ToInt32(e_id));
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