<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageStudent.aspx.cs" Inherits="Admin_ManageStudent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        .gv{
            width:95%;
            margin:0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h4 style="text-align:center"> Student List</h4>
       <h6><a href="AddStudent.aspx?action=add" style="color:black"><u>Add Student</u></a></h6>

        <asp:GridView ID="gvStudent" runat="server" CssClass="gv" AutoGenerateColumns="false" DataKeyNames="StudentID" OnRowCommand="gvStudent_RowCommand" HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EmailID" HeaderText="Email ID" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="MobileNo" HeaderText="Mobile No" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" ItemStyle-HorizontalAlign="Center"/>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditTable" CausesValidation="false" 
                           CommandArgument='<%# Eval("StudentID") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   
                  <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteTable" CausesValidation="false" 
                           CommandArgument='<%# Eval("StudentID") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField>
            </Columns>
        </asp:GridView> 
    </div>
</asp:Content>

