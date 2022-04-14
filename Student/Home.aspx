<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMaster.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Student_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .line {
          border-left: 2px solid green;
        }
        .text{
           overflow: hidden;
           text-overflow: ellipsis;
           display: -webkit-box;
           -webkit-line-clamp: 4; /* number of lines to show */
           -webkit-box-orient: vertical;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div id="carouselExampleControls" class="carousel slide" data-ride="carousel" style="height:500px;width:1350px">
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img class="w-100 img-thumbnail" src="Slideshow/img1.jpeg" alt="First slide" style="height:600px">
            </div>
           <%-- <div class="carousel-item">
              <img class="d-block w-100" src="Slideshow/img1.jpeg" alt="Second slide">
            </div>
            <div class="carousel-item">
              <img class="d-block w-100" src="Slideshow/img1.jpeg" alt="Third slide">
            </div>--%>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
    </div>


      <div style="z-index: 10;position: absolute;right: 5px;top: 20%; width:420px;overflow-y: scroll; height:400px;">
          <div class="card">
              <div class="card-header">
                    <h4>Upcoming Events</h4>
              </div>
                    <asp:Repeater ID="rptEvents" runat="server" OnItemCommand="rptEvents_ItemCommand">
                    <ItemTemplate>
                    <div class="card-body">
                            <div class="row">
                                  <div class="col-md-3">                      
                                      <h5><%#DataBinder.Eval(Container,"DataItem.StartDate")%></h5>
                                      <h5>&nbsp;&nbsp;&nbsp;&nbsp;-</h5>
                                      <h5><%#DataBinder.Eval(Container,"DataItem.EndDate")%></h5>
                                  </div>
                                  <div class="col-md-1 line">
                        
                                  </div>
                                 <div class="col-md-8">
                                     <h5> <%#DataBinder.Eval(Container,"DataItem.Name")%></h5>
                                     <p class="text"><%#DataBinder.Eval(Container,"DataItem.Description")%></p>
                                 </div>
                            </div>
                        <br/>
                        <asp:LinkButton ID="btnSelect" runat="server" CssClass="btn" Text="Participate Now" BackColor="Blue" ForeColor="White" CommandArgument='<%# Eval("EventID") %>' CommandName="Select"/>
                      </div>
                </ItemTemplate>
                        <SeparatorTemplate>
                            <hr />
                        </SeparatorTemplate>
            </asp:Repeater>
          </div>
      </div>

</asp:Content>

