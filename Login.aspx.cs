using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        try
        {
            string username = txtEmail.Text.ToString().Trim();
            string password = txtPass.Text.ToString().Trim();
            int type = Convert.ToInt32(ddType.SelectedValue);


            con = new SqlConnection(constr);

            if (type == 0)
            {
                lblError.Text = "Select login type";
                lblError.Visible = true;
            }
            else
            {
                if (type == 1)
                    cmd = new SqlCommand("select * from mstAdmin where Username=@username and Password=@pass", con);
                else
                    cmd = new SqlCommand("select * from mstStudent where EmailID=@username and Password=@pass", con);

                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@pass", password);
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    if (type == 1)
                    {
                        Session["uname"] = username;
                        Response.Redirect("Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Session["StudentID"] = dt.Rows[0]["StudentID"].ToString();
                        Response.Redirect("Student/Home.aspx");
                    }
                    lblError.Visible = false;
                }
                else
                    lblError.Visible = true;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}