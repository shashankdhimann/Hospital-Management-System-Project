using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_SYSTEM_29
{
    public partial class HMS_LOGIN : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCSL"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            // UnobtrusiveValidation jQuery 
            Page.UnobtrusiveValidationMode =
                System.Web.UI.UnobtrusiveValidationMode.None;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT * FROM HMD_DB WHERE Mobile=@Mobile and Pass=@Pass and Department=@Depart";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Mobile", txtEmployeeMobile.Text);
            cmd.Parameters.AddWithValue("@Pass",txtPassword.Text);
            cmd.Parameters.AddWithValue("@Depart", ddlRole.SelectedItem.Value);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if(dr.HasRows)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Login Pass successfully";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                Response.Redirect("PatientDEMO.aspx");
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Failed";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
                con.Close();
        }
    }
}