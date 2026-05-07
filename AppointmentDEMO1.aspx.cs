using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HMS_SYSTEM_29
{
    public partial class AppointmentDEMO1 : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCSA"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "INSERT INTO AppointmentDB (A_Name,A_Docter,A_Date) VALUES(@Name,@Doctor,@Date)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name", txtPName.Text);
            cmd.Parameters.AddWithValue("@Doctor", txtDName.Text);
            cmd.Parameters.AddWithValue("@Date", txtDate.Text);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            BindGridView();

            txtPName.Text = txtDName.Text = txtDate.Text = "";
        }
        void BindGridView()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT * FROM AppointmentDB";
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView3.DataSource = dt;
            GridView3.DataBind();
        }

        protected void GridView3_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView3.EditIndex = -1;
            BindGridView();
        }

        protected void GridView3_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);

            int id = Convert.ToInt32(GridView3.DataKeys[e.RowIndex].Value);

            con.Open();
            string query = "DELETE FROM AppointmentDB WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", id);
            cmd.ExecuteNonQuery();
            con.Close();

            BindGridView();
        }

        protected void GridView3_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView3.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView3_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);

            int id = Convert.ToInt32(GridView3.DataKeys[e.RowIndex].Value);
            TextBox txtPName = (TextBox)GridView3.Rows[e.RowIndex].FindControl("TextBoxPatientName");
            TextBox txtDName = (TextBox)GridView3.Rows[e.RowIndex].FindControl("TextBoxDoctorName");
            TextBox txtDate = (TextBox)GridView3.Rows[e.RowIndex].FindControl("TextBoxDate");
            try
            {
                con.Open();
            string query = "UPDATE AppointmentDB SET A_Name=@Name, A_Docter=@Doctor, A_Date=@Date WHERE Id=@id";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@Name", txtPName.Text);
            cmd.Parameters.AddWithValue("@Doctor", txtDName.Text);
            cmd.Parameters.AddWithValue("@Date", txtDate.Text);
            cmd.ExecuteNonQuery();

            GridView3.EditIndex = -1;
            BindGridView();
            }
            catch (Exception ex)
            {
                // Show or log the error
                Response.Write("Error: " + ex.Message);
            }
        }
    }
}