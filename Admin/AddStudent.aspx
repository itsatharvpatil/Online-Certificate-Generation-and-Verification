<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddStudent.aspx.cs" Inherits="Admin_AddStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h3 style="text-align:center"> Student Details </h3>
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                         <div class="form-group">
                            <label> Department </label>
                            <asp:DropDownList ID="ddDepartment" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6">
                         <div class="form-group">
                            <label> Academic Year </label>
                            <asp:DropDownList ID="ddYear" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> Name </label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ForeColor="Red" ErrorMessage="Required"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> Email ID </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Required"/>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$" ErrorMessage="Invalid email id " ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label> Mobile No </label>
                            <asp:TextBox ID="txtMobileNo" runat="server" CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtMobileNo" ForeColor="Red" ErrorMessage="Required"/>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtMobileNo" ValidationExpression="^[6-9]\d{9}$" ErrorMessage="Invalid mobile no " ForeColor="Red"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-footer">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Submit" OnClick="btnSubmit_Click"/>
            </div>
        </div>
    </div>
</asp:Content>

