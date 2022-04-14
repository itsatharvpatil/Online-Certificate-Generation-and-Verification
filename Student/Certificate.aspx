<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMaster.master" AutoEventWireup="true" CodeFile="Certificate.aspx.cs" Inherits="Student_Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
         <style>
        .gv{
            width:95%;
            margin:0 auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

       <h4 style="text-align:center"> Participation List</h4>
           <br />
        <asp:GridView ID="gvEvent" runat="server" CssClass="gv" AutoGenerateColumns="false" DataKeyNames="ParticipationID" 
            OnRowCommand="gvEvent_RowCommand" HeaderStyle-HorizontalAlign="Center" OnRowDataBound="gvEvent_RowDataBound">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="MobileNo" HeaderText="MobileNo" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="Event" HeaderText="Event" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EventType" HeaderText="Event Type" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="StartDate" HeaderText="StartDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="AcademicYear" HeaderText="Academic Year" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Center"/>
                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnGenerate" runat="server" Text="Download Certificate" CommandName="GenerateTable" CausesValidation="false" CommandArgument='<%# Eval("ParticipationID") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   

            </Columns>
        </asp:GridView> 
</asp:Content>

