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
    public partial class DocterDEMO : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["DBCSD"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                DisplayTotalDoctor();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "INSERT INTO DoctorDB (D_Name,D_Spec,D_Status) VALUES(@Name,@Spec,@Status)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name", txtDocName.Text);
            cmd.Parameters.AddWithValue("@Spec", ddlSpec.Text);
            cmd.Parameters.AddWithValue("@Status", ddlStatus.Text);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            BindGridView();
            DisplayTotalDoctor();
        }

        void BindGridView()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT * FROM DoctorDB ";
            SqlDataAdapter da = new SqlDataAdapter(query,con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView2.DataSource = dt;
            GridView2.DataBind();
        }

        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);

           int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);

            con.Open();
            string query = "DELETE FROM DoctorDB WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", id);
            cmd.ExecuteNonQuery();
            con.Close();

            BindGridView();
            DisplayTotalDoctor();
        }

        protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView2.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

            int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
            TextBox TextBoxName = (TextBox)GridView2.Rows[e.RowIndex].FindControl("TextBoxName");
            TextBox TextBoxSpec = (TextBox)GridView2.Rows[e.RowIndex].FindControl("TextBoxSpec");
            TextBox TextBoxStatus = (TextBox)GridView2.Rows[e.RowIndex].FindControl("TextBoxStatus");
            try
            {
                SqlConnection con = new SqlConnection(cs);

                con.Open();
                string query = "UPDATE DoctorDB SET D_Name=@Name, D_Spec=@Spec, D_Status=@Status WHERE Id=@id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
                cmd.Parameters.AddWithValue("@Spec", TextBoxSpec.Text);
                cmd.Parameters.AddWithValue("@Status", TextBoxStatus.Text);
                cmd.ExecuteNonQuery();

                GridView2.EditIndex = -1;
                BindGridView();
            }
            catch (Exception ex)
            {
                // Show or log the error
                Response.Write("Error: " + ex.Message);
            }

        }

        protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView2.EditIndex = -1;
            BindGridView();
        }

        void DisplayTotalDoctor()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) AS Total_Docter FROM DoctorDB";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            int Total_Doctor = (int)cmd.ExecuteScalar();

            lblPatients.Text = Total_Doctor.ToString();
            
        }
    }
    
}