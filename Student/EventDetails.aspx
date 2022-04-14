<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMaster.master" AutoEventWireup="true" CodeFile="~/Student/EventDetails.aspx.cs" Inherits="Student_EventDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h4 align="center">Upcoming Events</h4>
    <div style="margin-left:2%;width:95%;margin-top:5%">
        <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand" >
            <ItemTemplate>
                <table border="0" style="width:100%">
                    <tr>
                        <td style="width:85%"><b><%#DataBinder.Eval(Container,"DataItem.Name")%></b></td>
                        <td rowspan="2"><asp:LinkButton ID="btnSelect" runat="server" CssClass="btn" Text="Participate" BackColor="Blue" CommandArgument='<%# Eval("EventID") %>' CommandName="Select"
                               ForeColor="White"/></td>
                    </tr>
                    <tr>
                        <td><%#DataBinder.Eval(Container,"DataItem.Description")%></td>
                    </tr>
                    <tr>
                        <td><%#DataBinder.Eval(Container,"DataItem.StartDate")%> - <%#DataBinder.Eval(Container,"DataItem.EndDate")%></td>
                    </tr>
                </table>
            </ItemTemplate>
             <SeparatorTemplate>
                <tr>
                    <td>
                        <hr style="background-color:blue" />
                    </td>
                </tr>
            </SeparatorTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

