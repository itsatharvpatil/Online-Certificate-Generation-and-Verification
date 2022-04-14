<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AddEvent.aspx.cs" Inherits="Admin_AddEvent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h3 style="text-align:center"> Event Details </h3>
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
                            <label> Event Type </label>
                            <asp:DropDownList ID="ddEventType" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label> Event Name </label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"/>
                        </div>
                    </div>
                     <div class="col-md-6">
                        <label>Start Date</label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtDate" ErrorMessage="Required" ForeColor="Red" />
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control"/>                 
                            </div>
                            <div class="col-md-6">
                                 <asp:ImageButton ID="imgCal" runat="server" OnClick="imgCal_Click" ImageUrl="../assets/img/cal.png" CausesValidation="false"/>
                                 <asp:Calendar ID="cal" runat="server" Visible="false" OnSelectionChanged="cal_SelectionChanged"/>
                            </div>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <label>End Date</label>
                        &nbsp;<asp:RequiredFieldValidator runat="server" ControlToValidate="txtEDate" ErrorMessage="Required" ForeColor="Red" />
                        <div class="row">
                            <div class="col-md-6">
                                <asp:TextBox ID="txtEDate" runat="server" CssClass="form-control"/>                 
                            </div>
                            <div class="col-md-6">
                                 <asp:ImageButton ID="imgECal" runat="server" OnClick="imgECal_Click" ImageUrl="../assets/img/cal.png" CausesValidation="false"/>
                                 <asp:Calendar ID="eCal" runat="server" Visible="false" OnSelectionChanged="eCal_SelectionChanged"/>
                            </div>
                        </div>
                    </div>   
                    <div class="col-md-12">
                       <div class="form-group">
                            <label> Description </label>
                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control"/>
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

