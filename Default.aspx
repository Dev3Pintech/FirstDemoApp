<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FirstDemoApp._Default" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:HiddenField ID="EmployeeId" runat="server" />
   
    <div class="row">
        <div class="col-md-4">

        </div>
         <div class="col-md-4" style="margin-top: 20px; background-color: cornflowerblue; margin-bottom: 20px; padding: 50px">
             <div style="margin-top: 20px">
                  <div class="form-group">
                    <label for="exampleInputEmail1">Employee Name</label>
                      <asp:TextBox ID="TextEmployeeName" runat="server" class="form-control" placeholder="Enter your name" style="margin-top: 0px"></asp:TextBox>
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Salary</label>
                      <asp:TextBox ID="TextSalary" runat="server" class="form-control" placeholder="Enter Salary"></asp:TextBox>
                  </div>
                 <div class="form-group">
                    <label for="Department">Department</label>
                      <asp:TextBox ID="TextDepartment" runat="server" class="form-control" placeholder="Enter Department"></asp:TextBox>
                  </div>
                 <div class="row">
                     <div class="col-md-4">
                        <asp:Button type="submit" class="btn btn-primary" ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" Width="90px" />
                     </div>
                     <div class="col-md-8" style="margin-top: 8px">
                        <asp:Label ID="lblSuccessMessage" Visible="false" runat="server" CssClass="alert alert-success" ForeColor="Green" Text=""></asp:Label>
                     </div>
                 </div>
            </div>
        </div> 
         <div class="col-md-4">

        </div>
    </div>

    <div class="row">
        <div class="col-md-2">

        </div>
        <div class="col-md-8">
            <table class="table table-striped table-hover" style="width: 97%">
                <asp:GridView ID="gvEployee" OnRowEditing="GridView_RowEditing" OnRowUpdating="GridView_RowUpdating" OnRowDeleting="GridView_RowDeleting" class="table table-striped" runat="server" Height="194px" Width="100%" HeaderStyle-BackColor="#3AC0F2" AutoGenerateColumns="false" HeaderStyle-ForeColor="White">
                   
                    <Columns>
                        <asp:TemplateField HeaderText="Employee Id" ItemStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="textRowEmployeeId" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"EmployeeId"))%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <asp:TextBox ID="textRowEmployeeId" Text='<%# Eval("EmployeeId")%>' runat="server" CssClass="edit-textbox-dona" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Employee Name">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="textRowEmployeeName" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"EmployeeName"))%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                 <asp:TextBox ID="textRowEmployeeName" Text='<%# Eval("EmployeeName")%>' runat="server" CssClass="edit-textbox-dona" />
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Salary">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="textRowSalary" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"Salary"))%>' />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="textRowSalary" Text='<%# Eval("Salary") %>'  runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                         <asp:TemplateField HeaderText="Department">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="textRowDepartment" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"Department"))%>' />
                            </ItemTemplate>
                              <EditItemTemplate>
                                <asp:TextBox ID="textRowDepartment" Text='<%# Eval("Department") %>'  runat="server"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>

                           <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                        <asp:Button ID="editB" runat="server" class="btn btn-success" CommandName="Edit" Text="Edit"></asp:Button>
                                        <asp:LinkButton ID="DeleteIconButoon" runat="server" CommandArgument='<%# Eval("EmployeeId") %>' OnClick="btnDelete_Click"  class="btn btn-danger"><i class="far fa-trash-alt">Delete</i></asp:LinkButton>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Button ID="upB" runat="server" class="btn btn-success" CommandName="Update" Text="Update"></asp:Button>
                                        <%--<asp:Button ID="canB" runat="server" class="btn btn-secondary" CommandName="Cancel" Text="Cancel"></asp:Button>--%>
                                        <%--<asp:Button ID="delB" runat="server" class="btn btn-danger" CommandName="Delete" Text="Delete"></asp:Button>--%>
                                        <asp:LinkButton ID="DeleteIconButoon" runat="server" CommandArgument='<%# Eval("EmployeeId") %>' OnClick="btnDelete_Click"  class="btn btn-danger"><i class="far fa-trash-alt">Delete</i></asp:LinkButton>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                       <%-- <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="editB" runat="server" class="btn btn-success" CommandName="Edit" Text="Edit"></asp:Button>
                                <asp:LinkButton ID="EditIconButoon" runat="server" CommandArgument='<%# Eval("EmployeeId") %>' OnClick="btnEdit_Click" class="btn btn-success"><i class="fas fa-edit">Edit</i></asp:LinkButton>
                                <asp:LinkButton ID="DeleteIconButoon" runat="server" CommandArgument='<%# Eval("EmployeeId") %>' OnClick="btnDelete_Click"  class="btn btn-danger"><i class="far fa-trash-alt">Delete</i></asp:LinkButton>
                                <asp:LinkButton ID="UpdateIconButoon" runat="server" CommandArgument='<%# Eval("EmployeeId") %>' OnClick="btnUpdate_Click"  class="btn btn-warning"><i class="far fa-trash-alt">Update</i></asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
            </table>
        </div>
        <div class="col-md-2" style="left: 3px; top: 62px">
            <asp:Button ID="report" runat="server" Text="Employee Report" OnClick="report_Click" />
        </div>
    </div>
    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8" style="margin-top: 100px">
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" BackColor="" ClientIDMode="AutoID" Height="326px" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226" Width="735px">
                <%--<LocalReport ReportPath="EmployeeReport.rdlc">
                    <DataSources>
                        <rsweb:ReportDataSource DataSourceId="ObjectDataSource1" Name="DataSet1" />
                    </DataSources>
                </LocalReport>--%>
            </rsweb:ReportViewer>
            <%--<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetData" TypeName="FirstDemoApp.DataSet1TableAdapters.EmployeesTableAdapter"></asp:ObjectDataSource>--%>
            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CustomerDBConnectionString2 %>" SelectCommand="SELECT * FROM [Customers]"></asp:SqlDataSource>--%>
        </div>
        <div class="col-md-2"></div>
    </div>
   
</asp:Content>

