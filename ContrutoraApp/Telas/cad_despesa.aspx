<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_despesa.aspx.cs" Inherits="ContrutoraApp.cad_despesa" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <script type="text/javascript" src="../Scripts/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>

    <title>Despesa</title>
</head>
<body runat="server">
    <form id="form1" runat="server">
        <div>
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Tipo Despesa</h3>
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtNome" placeholder="Nome" Width="400px" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtUsuarioSenha" Width="250px" placeholder="Login" CssClass="form-control" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <center>
                                <input type="button" id="btnGravar" value="Gravar" runat="server" class="btn btn-success" onclick="GravarUsuario()" />
                            </center>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
            </center>
        </div>
    </form>
</body>
</html>
