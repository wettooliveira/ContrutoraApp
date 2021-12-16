<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ContrutoraApp.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link rel="stylesheet" type="text/css" href="Css/Content/bootstrap.min.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="Css/style.css" media="screen"/>
    <link href='https://fonts.googleapis.com/css?family=Ubuntu' rel='stylesheet' type='text/css' />
    <script type="text/javascript" src="Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
    <script type="text/javascript" src="Scripts/SweetAlert2/sweetalert2.all.min.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script>



        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });

        $(document).ready(function () {

            // Click event of the showPassword button
            $('#showPassword').on('click', function () {

                // Get the password field
                var passwordField = $('#password');

                // Get the current type of the password field will be password or text
                var passwordFieldType = passwordField.attr('type');

                // Check to see if the type is a password field
                if (passwordFieldType == 'password') {
                    // Change the password field to text
                    passwordField.attr('type', 'text');

                    // Change the Text on the show password button to Hide
                    $(this).val('Ocultar');
                } else {
                    // If the password field type is not a password field then set it to password
                    passwordField.attr('type', 'password');

                    // Change the value of the show password button to Show
                    $(this).val('Mostar');
                }
            });
        });

    </script>


    <style type="text/css">

        .Imagem {
    background-image: url(../Imagem/Acai2.jpeg.jpeg);
    background-attachment: fixed;
    background-repeat: no-repeat;
    background-color: black;
    opacity: inherit;
    position: relative;
}

        .auto-style1 {
            height: 48px;
        }

        .button {
            background: #eee;
            border: 1px solid #999;
            cursor: pointer;
            padding: 6px !important;
        }

            .button:hover {
                background: #ddd;
            }

     
    </style>
</head>
<body class="">
    <div >

        <form id="form1" runat="server" >
            <asp:HiddenField ID="hdnAcao" runat="server" />
            <asp:HiddenField ID="hdnLogin" runat="server" />
            <div>
            </div>
            <table style="width: 100%">
                <tr>
                    <td align="center">
                        <table style="width: 50%; margin-top: 8%; margin: 60px">
                            <tr>
                                <td align="center">
                                    <h4><label style="color:black">Faça seu login!</label></h4>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <hr />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="height: 45px">

                                    <asp:TextBox ID="txtUsuario" runat="server" Style="width: 225px" CssClass="form-control-css" placeholder="Usuario" />
                            </tr>
                            <tr>
                                <td align="center" style="height: 45px">
                                    <p>
                                        <input id="password" name="password" type="password" runat="server" style="width: 225px" class="form-control-css" placeholder="Senha" />
                                        <%--<input type="button" id="showPassword" value="Mostrar" class="btn btn-default"  />--%>
                                    </p>

                                    <asp:Label ID="lblAviso" Font-Names="verdana" runat="server" ForeColor="Red" Visible="false" Text="Usuario ou Senha incorreto"></asp:Label>

                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="checkbox" align="center">
                                    <asp:CheckBox runat="server" ID="chkLembrar" />
                                    <asp:Label runat="server" ForeColor="White" >Lembrar-me?</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnLogin" Text="Login" runat="server" CssClass="btn btn-default"  />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <hr />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>



            <%--<div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Faça seu logon.</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">Nome de usuário</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                CssClass="text-danger" ErrorMessage="O campo nome de usuário é obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Senha</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="O campo de senha é obrigatório." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Lembrar-me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" Text="Logon" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>

            </section>
        </div>
        </table>--%>
        </form>
    </div>
</body>
</html>
