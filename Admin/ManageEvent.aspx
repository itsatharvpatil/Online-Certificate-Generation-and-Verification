<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageEvent.aspx.cs" Inherits="Admin_ManageEvent" %>

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
       <h4 style="text-align:center"> Event List</h4>
       <h6><a href="AddEvent.aspx?action=add" style="color:black"><u>Add Event</u></a></h6>
        <asp:GridView ID="gvEvent" runat="server" CssClass="gv" AutoGenerateColumns="false" DataKeyNames="EventID" OnRowCommand="gvEvent_RowCommand" HeaderStyle-HorizontalAlign="Center">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="Description" HeaderText="Description" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="StartDate" HeaderText="StartDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EndDate" HeaderText="EndDate" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="DepartmentName" HeaderText="Department" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField DataField="EventType" HeaderText="Event Type" ItemStyle-HorizontalAlign="Center"/>

                <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditTable" CausesValidation="false" CommandArgument='<%# Eval("EventID") %>' BackColor="#2c92e6" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
                </asp:TemplateField>   
                  <asp:TemplateField ShowHeader="False" ItemStyle-HorizontalAlign="Center">
                   <ItemTemplate>
                       <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteTable" CausesValidation="false" CommandArgument='<%# Eval("EventID") %>' BackColor="Red" ForeColor="White" CssClass="btn"/>
                   </ItemTemplate>
               </asp:TemplateField>
            </Columns>
        </asp:GridView> 
    </div>
</asp:Content>

