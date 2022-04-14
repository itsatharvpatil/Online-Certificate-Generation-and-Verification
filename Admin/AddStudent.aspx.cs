using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;

public partial class Admin_AddStudent : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["connect"].ToString();
    SqlConnection con;
    SqlCommand cmd;
    SqlDataAdapter da;
    DataTable dt;
    string s_id, e_id;
    string operation;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["uname"] == "")
            Response.Redirect("../Login.aspx");

        operation = Request.QueryString["action"].ToString();

        if (operation.Trim() == "edit")
            s_id = Request.QueryString["id"].ToString();

        if (!IsPostBack)
        {
            fillDropDownList();
            if (operation.Trim() == "edit")
            {
                getStudentDetails(s_id);
            }
        }
    }

    private void getStudentDetails(string s_id)
    {
        try
        {
            con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_select_mstStudent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@iStudentID", Convert.ToInt32(s_id));
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                txtEmail.Enabled = false;
                ddDepartment.SelectedValue = dt.Rows[0]["DepartmentID"].ToString();
                ddYear.SelectedValue = dt.Rows[0]["YearID"].ToString();
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtEmail.Text = dt.Rows[0]["EmailID"].ToString();
                txtMobileNo.Text = dt.Rows[0]["MobileNo"].ToString();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void fillDropDownList()
    {
        try
        {
            con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("select * from Auto_Year", con);
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                ddYear.DataSource = dt;
                ddYear.DataValueField = "YearID";
                ddYear.DataTextField = "Description";
                ddYear.DataBind();
            }

            SqlCommand cmd1 = new SqlCommand("select * from Auto_Department where DepartmentID not in (0)", con);
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            con = new SqlConnection(constr);
            if (con.State != ConnectionState.Open)
                con.Open();
            if (operation == "add")
                cmd = new SqlCommand("insert into mstStudent values (@name,@email,@pass,@mobileno,@did,@yid)", con);
            else
                cmd = new SqlCommand("update mstStudent set Name=@name,MobileNo=@mobileno,DepartmentID=@did,YearID=@yid where StudentID = @student_id", con);
            string pd = RandomString(6);
            cmd.Parameters.AddWithValue("@student_id", Convert.ToInt32(s_id));
            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@pass", pd);
            cmd.Parameters.AddWithValue("@mobileno", txtMobileNo.Text);
            cmd.Parameters.AddWithValue("@did", ddDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@yid", ddYear.SelectedValue);
            if (sendMail(txtEmail.Text, "Your password is: " + pd))
            {
                int result = cmd.ExecuteNonQuery();
                if (result == 1)
                {
                    Response.Write("<script>alert('Data inserted successfully')</script>");
                    Response.Redirect("ManageStudent.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Something went wrong')</script>");
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public static string RandomString(int length)
    {
        var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        var stringChars = new char[length];
        var random = new Random();

        for (int i = 0; i < stringChars.Length; i++)
        {
            stringChars[i] = chars[random.Next(chars.Length)];
        }

        return new string(stringChars);
    }


    private bool sendMail(string email, string body)     // send email when status updates
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("project.mail1231@gmail.com");  // dummy gmail account email
            SmtpClient smtp = new SmtpClient();
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtp.UseDefaultCredentials = false;
            smtp.Credentials = new NetworkCredential("project.mail1231@gmail.com", "project12345"); // dummy acc email and pass
            smtp.Host = "smtp.gmail.com";

            //recipient address
            mail.To.Add(new MailAddress(email));    // receiver's email address
            mail.Subject = "New Notification";
            mail.Body = body;   // body of email
            smtp.Send(mail);
            return true;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}