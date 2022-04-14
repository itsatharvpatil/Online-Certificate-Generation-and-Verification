<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ApproveCertificate.aspx.cs" Inherits="Admin_ApproveCertificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        .gv{
            width:99%;
            margin:0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="container">
       <h4 style="text-align:center"> Participation List</h4>

        <asp:GridView ID="gvApprove" runat="server" CssClass="gv" AutoGenerateColumns="false" DataKeyNames="ParticipationID" OnRowCommand="gvApprove_RowCommand" HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="Event" HeaderText="Event" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EventType" HeaderText="Event Type" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="StartDate" HeaderText="StartDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" ItemStyle-HorizontalAlign="Center"/>

                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnEdit" runat="server" Text="Approve" CommandName="ApproveTable" CausesValidation="false" CommandArgument='<%# Eval("ParticipationID") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   
                  <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Reject" CommandName="RejectTable" CausesValidation="false" CommandArgument='<%# Eval("ParticipationID") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField>
            </Columns>
        </asp:GridView> 
    </div>
</asp:Content>

