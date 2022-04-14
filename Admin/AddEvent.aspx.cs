using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddEvent : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string v_id, e_id;
    string operation;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == "")
            Response.Redirect("../Login.aspx");


        operation = Request.QueryString["action"].ToString();

        if (operation.Trim() == "edit")
            e_id = Request.QueryString["id"].ToString();

        if (!IsPostBack)
        {
            fillDropDownList();
            if (operation.Trim() == "edit")
            {
                getEventDetails(e_id);
            }
        }
    }

    private void getEventDetails(string e_id)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_mstEvent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iEventID", Convert.ToInt32(e_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count > 0)
            {
                ddDepartment.SelectedValue = dt.Rows[0]["DepartmentID"].ToString();
                ddEventType.SelectedValue = dt.Rows[0]["EventTypeID"].ToString();
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtDate.Text = dt.Rows[0]["StartDate"].ToString();
                txtEDate.Text = dt.Rows[0]["EndDate"].ToString();
                txtDesc.Text = dt.Rows[0]["Description"].ToString();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

    private void fillDropDownList()
    {
        try
        {
            con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("select * from Auto_EventType", con);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddEventType.DataSource = dt;
                ddEventType.DataValueField = "EventTypeID";
                ddEventType.DataTextField = "Description";
                ddEventType.DataBind();
            }

            SqlCommand cmd1 = new SqlCommand("select * from Auto_Department", con);
            DataTable dt1 = new DataTable();
            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            da1.Fill(dt1);
            if (dt1.Rows.Count > 0)
            {
                ddDepartment.DataSource = dt1;
                ddDepartment.DataValueField = "DepartmentID";
                ddDepartment.DataTextField = "DepartmentName";
                ddDepartment.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void imgCal_Click(object sender, ImageClickEventArgs e)
    {
        cal.Visible = true;
    }
    protected void cal_SelectionChanged(object sender, EventArgs e)
    {
        txtDate.Text = cal.SelectedDate.ToShortDateString(); // just use this method to get dd/MM/yyyy  
        cal.Visible = false;
    }

    protected void imgECal_Click(object sender, ImageClickEventArgs e)
    {
        eCal.Visible = true;
    }
    protected void eCal_SelectionChanged(object sender, EventArgs e)
    {
        txtEDate.Text = eCal.SelectedDate.ToShortDateString(); // just use this method to get dd/MM/yyyy  
        eCal.Visible = false;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();
            if (operation == "add")
                cmd = new SqlCommand("insert into mstEvent values (@name,@desc,@sdate,@edate,@did,@eid)", con);
            else
                cmd = new SqlCommand("update mstEvent set Name=@name,Description=@desc,StartDate=@sdate,EndDate=@edate,DepartmentID=@did,EventTypeID=@eid where EventID = @event_id", con);

            cmd.Parameters.AddWithValue("@event_id",Convert.ToInt32(e_id));
            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@desc", txtDesc.Text);
            cmd.Parameters.AddWithValue("@sdate", Convert.ToDateTime(txtDate.Text));
            cmd.Parameters.AddWithValue("@edate", Convert.ToDateTime(txtEDate.Text));
            cmd.Parameters.AddWithValue("@did", ddDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@eid", ddEventType.SelectedValue);
            int result = cmd.ExecuteNonQuery();
            if (result == 1)
            {
                Response.Write("<script>alert('Data inserted successfully')</script>");
                Response.Redirect("ManageEvent.aspx");
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