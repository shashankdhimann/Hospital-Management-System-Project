using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace HMS_SYSTEM_29
{
    public partial class PatientDEMO : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["BDCSP"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
                DisplayTotalPatient();
                DisplayTotalAppoitment();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "INSERT INTO Patient_Data(P_Name,P_Age,P_Gender,P_Mobile) VALUES(@Name,@Age,@Gender,@Mobile)";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name",txtName.Text);
            cmd.Parameters.AddWithValue("@Age", txtAge.Text);
            cmd.Parameters.AddWithValue("@Mobile", txtPhone.Text);
            cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedItem.Value);
            con.Open();
            int a = cmd.ExecuteNonQuery();
            if (a > 0)
            {
                string script = "Swal.fire('Saved!', 'Data has been updated.', 'success');";
                ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", script, true);

                BindGridView();
                DisplayTotalPatient();
                DisplayTotalAppoitment();
                txtName.Text = "";
                txtAge.Text = "";
                txtPhone.Text = "";
                ddlGender.SelectedIndex = 0;
            }
            else
            {
                string script = "Swal.fire('Saved!', 'Data inserted failed.', 'failed');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
            }
                con.Close();

        }

        private void BindGridView()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT * FROM Patient_Data";
            SqlDataAdapter da = new SqlDataAdapter(query, con);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridViewpatient.DataSource = dt;
            GridViewpatient.DataBind();
        }

        protected void GridViewpatient_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);

            int id = Convert.ToInt32(GridViewpatient.DataKeys[e.RowIndex].Value);

            con.Open();
            string query = "DELETE FROM Patient_Data WHERE Id = @ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", id);
            cmd.ExecuteNonQuery();
            con.Close();

            BindGridView();
            DisplayTotalPatient();
            DisplayTotalAppoitment();
        }

        protected void GridViewpatient_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewpatient.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridViewpatient_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            SqlConnection con = new SqlConnection(cs);

            int id = Convert.ToInt32(GridViewpatient.DataKeys[e.RowIndex].Value);
            TextBox TextBoxName = (TextBox)GridViewpatient.Rows[e.RowIndex].FindControl("TextBoxName");
            TextBox TextBoxAge = (TextBox)GridViewpatient.Rows[e.RowIndex].FindControl("TextBoxAge");
            TextBox TextBoxGender = (TextBox)GridViewpatient.Rows[e.RowIndex].FindControl("TextBoxGender");
            TextBox TextBoxMobile = (TextBox)GridViewpatient.Rows[e.RowIndex].FindControl("TextBoxMobile");

            con.Open();
            string query = "UPDATE Patient_Data SET P_Name=@Name, P_Age=@Age, P_Gender=@Gender, P_Mobile=@Phone WHERE Id=@ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ID", id);
            cmd.Parameters.AddWithValue("@Name", TextBoxName.Text);
            cmd.Parameters.AddWithValue("@Phone", TextBoxMobile.Text);
            cmd.Parameters.AddWithValue("@Age",TextBoxAge.Text);
            cmd.Parameters.AddWithValue("@Gender", TextBoxGender.Text);

            cmd.ExecuteNonQuery();
            con.Close();

            GridViewpatient.EditIndex = -1;
            BindGridView();
        }

        protected void GridViewpatient_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewpatient.EditIndex = -1;
            BindGridView();
        }

        void DisplayTotalPatient()
        {
            SqlConnection con = new SqlConnection(cs);
            String query = "SELECT COUNT(*) AS Total_Patient FROM Patient_Data";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            int totalPatients = (int)cmd.ExecuteScalar();

            lblPatients.Text = totalPatients.ToString();
        }

        void DisplayTotalAppoitment()
        {
            SqlConnection con = new SqlConnection(cs);
            string query = "SELECT COUNT(*) AS Total_Appointment FROM AppointmentDB";
            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            int totalAppointment = (int)cmd.ExecuteScalar();
            lblAppointments.Text = totalAppointment.ToString();
        }
    }
}