using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FirstDemoApp
{
    public partial class _Default : Page
    {
        SqlConnection sqlcon = new SqlConnection(@"Data Source = ANIK-PC\MSSQL2K14; Initial Catalog = CustomerDB; Integrated Security = true");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //btnDelete.Enabled = false;
                EmployeeTableGridView();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            EmployeeId.Value = "";
            TextEmployeeName.Text = TextSalary.Text = TextDepartment.Text = "";
            lblSuccessMessage.Text = String.Empty;
           
            btnSave.Text = "Save";
            //btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            this.lblSuccessMessage.Visible = true;
            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlCommand sqlcmd = new SqlCommand("EmployeeCreateOrUpdate", sqlcon);
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.AddWithValue("@EmployeeId",(EmployeeId.Value ==""? 0:Convert.ToInt32(EmployeeId.Value)));
            sqlcmd.Parameters.AddWithValue("@EmployeeName",TextEmployeeName.Text.Trim());
            sqlcmd.Parameters.AddWithValue("@Salary",TextSalary.Text.Trim());
            sqlcmd.Parameters.AddWithValue("@Department",TextDepartment.Text.Trim());
            sqlcmd.ExecuteNonQuery();
            sqlcon.Close();
            Clear();

            if (EmployeeId.Value == "")
            {
                lblSuccessMessage.Text = "Save Successfully.";
                lblSuccessMessage.Attributes.Add("class", "alert alert-success");
                lblSuccessMessage.Attributes.CssStyle.Add("class", "alert alert-success");
            }

            else
            {
                lblSuccessMessage.Text = "Some thing went wrong";
                lblSuccessMessage.Attributes.Add("class", "alert alert-danger");
                lblSuccessMessage.Attributes.CssStyle.Add("class", "alert alert-danger");
            }
               

            EmployeeTableGridView();
            
        }

        protected void BtnDelete_Click(object sender, EventArgs e)
        {

        }

        void EmployeeTableGridView()
        {
            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlDataAdapter sqlDA = new SqlDataAdapter("EmployeeViewAll", sqlcon);
            sqlDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDA.Fill(dtbl);
            sqlcon.Close();
            gvEployee.DataSource = dtbl;
            gvEployee.DataBind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            int Employeeid = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlDataAdapter Da = new SqlDataAdapter("GetEmployeeById", sqlcon);
            Da.SelectCommand.CommandType = CommandType.StoredProcedure;
            Da.SelectCommand.Parameters.AddWithValue("@Id", Employeeid);
            DataTable dtbl = new DataTable();
            Da.Fill(dtbl);
            sqlcon.Close();
            EmployeeId.Value = Employeeid.ToString();
            TextEmployeeName.Text = dtbl.Rows[0]["EmployeeName"].ToString();
            TextSalary.Text = dtbl.Rows[0]["Salary"].ToString();
            TextDepartment.Text = dtbl.Rows[0]["Department"].ToString();
            btnSave.Text = "Update";
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEployee.EditIndex = e.NewEditIndex;
            EmployeeTableGridView();
        }

        protected void GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            //Label id = gvEployee.Rows[e.RowIndex].FindControl("EmployeeIdRow.value") as Label;
            TextBox EmployeeId = gvEployee.Rows[e.RowIndex].FindControl("textRowEmployeeId") as TextBox;
            TextBox EmployeeName = gvEployee.Rows[e.RowIndex].FindControl("textRowEmployeeName") as TextBox;
            TextBox textSalary = gvEployee.Rows[e.RowIndex].FindControl("textRowSalary") as TextBox;
            TextBox textDepartment = gvEployee.Rows[e.RowIndex].FindControl("textRowDepartment") as TextBox;

            int employeeId = Convert.ToInt32(EmployeeId.Text);
            string named = EmployeeName.Text;
            string aSalary = textSalary.Text;
            string aDepartment = textDepartment.Text;

            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlCommand sqlcmd = new SqlCommand("EmployeeCreateOrUpdate", sqlcon);
            sqlcmd.CommandType = CommandType.StoredProcedure;
            sqlcmd.Parameters.AddWithValue("@EmployeeId", (EmployeeId.Text == "" ? 0 : Convert.ToInt32(employeeId)));
            sqlcmd.Parameters.AddWithValue("@EmployeeName", named.Trim());
            sqlcmd.Parameters.AddWithValue("@Salary", aSalary.Trim());
            sqlcmd.Parameters.AddWithValue("@Department", aDepartment.Trim());
            sqlcmd.ExecuteNonQuery();
            sqlcon.Close();

            EmployeeTableGridView();
        }

        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = gvEployee.Rows[e.RowIndex].FindControl("EmployeeId") as Label;
            int iddemo = Convert.ToInt32(id.Text);

            sqlcon.Open();
            SqlCommand cmd = new SqlCommand("delete from Employees where EmployeeId= '" + iddemo + "' ", sqlcon);
            int t = cmd.ExecuteNonQuery();
            sqlcon.Close();
            if (t > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "swal('Deleted','', 'error').then((value) => { window.location ='Default.aspx'; });", true);
                gvEployee.EditIndex = -1;
                EmployeeTableGridView();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int id = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlDataAdapter Da = new SqlDataAdapter("DeleteEmployeeById", sqlcon);
            Da.SelectCommand.CommandType = CommandType.StoredProcedure;
            Da.SelectCommand.Parameters.AddWithValue("@Id", id);
            DataTable dtbl = new DataTable();
            Da.Fill(dtbl);
            sqlcon.Close();
            EmployeeTableGridView();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Are you sure you want delete this item?');", true);
        }

        protected void report_Click(object sender, EventArgs e)
        {
            if (sqlcon.State == ConnectionState.Closed)
                sqlcon.Open();
            SqlDataAdapter sqlDA = new SqlDataAdapter("EmployeeViewAll", sqlcon);
            sqlDA.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDA.Fill(dtbl);
            sqlcon.Close();

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource source = new ReportDataSource("DataSet1", sqlcon);
            ReportViewer1.LocalReport.ReportPath = "EmployeeReport.rdlc";
            ReportViewer1.LocalReport.DataSources.Add(source);
            //ReportViewer1.ReportRefresh();
        }
    }
}