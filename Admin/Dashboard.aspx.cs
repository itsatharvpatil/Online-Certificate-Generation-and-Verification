using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Dashboard : System.Web.UI.Page
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
        try{
        con = new SqlConnection(constr);
            cmd = new SqlCommand("usp_dashboard", con);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                lblStudent.Text = dt.Rows[0]["Count"].ToString();
                lblEvent.Text = dt.Rows[1]["Count"].ToString();
                lblParticipation.Text = dt.Rows[2]["Count"].ToString();
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }

    }
}