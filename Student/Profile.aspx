<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMaster.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Mentor_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h4 align="center">Select Course</h4>
    <div style="margin-left:2%;width:95%;margin-top:5%">
        <asp:Repeater ID="rptCourse" runat="server" OnItemCommand="rptCourse_ItemCommand" >
            <ItemTemplate>
                <table border="0" style="width:100%">
                    <tr>
                        <td style="width:6%"><b>Type:</b></td>
                        <td style="width:85%"><%#DataBinder.Eval(Container,"DataItem.Name")%></td>
                        <td rowspan="2"><asp:LinkButton ID="btnSelect" runat="server" CssClass="btn" Text="Select" BackColor="Blue" CommandArgument='<%# Eval("EventID") %>' CommandName="Select"/></td>
                    </tr>
                    <tr>
                        <td><b>Name:</b></td>
                        <td><%#DataBinder.Eval(Container,"DataItem.Description")%></td>
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

