<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_usuario.aspx.cs" Inherits="cad_usuario" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <link rel="stylesheet" type="text/css" href="../Css/Content/bootstrap.min.css" media="screen" />
    <%--    <script type="text/javascript" src="../Scripts/bootstrap.js"></script>--%>
    <%--   <script type="text/javascript" src="../Scripts/jquery-3.4.1.js"></script>--%>
    <script type="text/javascript" src="../Scripts/jquery-3.3.1.js"></script>
    <%--    <script type="text/javascript" src="../Scripts/bootstrap.min.js"></script>--%>
    <script type="text/javascript" src="../Scripts/SweetAlert2/sweetalert2.all.min.js"></script>


    <title>Usuarios</title>

    <script type="text/javascript">

        $(document).ready(function () {

            // Click event of the showPassword button
            $('#showPassword').on('click', function () {

                // Get the password field
                var passwordField = $('#txtSenha');

                // Get the current type of the password field will be password or text
                var passwordFieldType = passwordField.attr('type');

                // Check to see if the type is a password field
                if (passwordFieldType == 'Password') {
                    // Change the password field to text
                    passwordField.attr('type', 'text');

                    // Change the Text on the show password button to Hide
                    $(this).val('Ocultar');
                } else {
                    // If the password field type is not a password field then set it to password
                    passwordField.attr('type', 'Password');

                    // Change the value of the show password button to Show
                    $(this).val('Mostrar');
                }
            });
        });

        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });


        function openCidade() {
            abrir_janela("loc_regiao.aspx", "lr", 600, 350, 1);
        }

        function alertCss(mensagem) {

            texto == '';
            icon == '';
            if (mensagem == ('Gravar')) {
                var texto = ('Gravado com sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('Alterar')) {
                var texto = ('Alterado com Sucesso');
                var icon = ('success');
            }
            else if (mensagem == ('tipo')) {
                var texto = ('Campo Obrigatório');
                var icon = ('error');
            }

            swalWithBootstrapButtons.fire({
                title: '',
                text: texto,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            });
        }

        function nome(id_usuario) {            
            $('#hdnId_usuario').val('');
            $('#hdnId_usuario').val(id_usuario);
        }

        function CarregarInf() {
            document.getElementById("txtNomeModal").value = document.getElementById("txtNome").value;
            document.getElementById("txtUsuarioModal").value = document.getElementById("txtUsuarioSenha").value;
        }

        function GravarUsuario() {

            var id = $('#hdnId_usuario').val();
            var nome = $('#txtNome').val();
            var login = $('#txtUsuarioSenha').val();
            var senha = $('#txtSenha').val();
            var usuario = $('#hdnUsuario').val();
            var btn = $('#btnGravar').val()

            var Usuario = {
                id_usuario: id,
                ds_nome: nome,
                nm_login: login,
                senha: senha,
                nm_cadastrou: usuario,
                usuario: btn

            };

            console.log(Usuario);

            var obj = { 'usuario': Usuario };
                       

            $.ajax({
                type: "POST",
                url: "cad_usuario.aspx/Gravar_Usuario",
                /*data: "{'m':'m'}",*/
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    if (source.split(';')[0] == 'OK') {
                        alertCss(source.split(';')[1]);
                    }
               
                },
                error: function (request, status, error) {
                    alert(request.responseText);
                    console.log(request.responseText);
                    //swalWithBootstrapButtons.fire({
                    //    title: '',
                    //    text: 'Erro ao abrir tabela! Tente novamente!',
                    //    icon: 'error',
                    //    confirmButtonText: 'OK',
                    //    allowOutsideClick: false
                    //}).then((result) => {
                    /*  });*/
                }
            });

        }

    </script>

    <style type="text/css">
        /* Estilo do alert */
        .swal2-popup {
            font-size: medium !important;
        }

        .btn {
            margin: 0 0.5rem;
            font-size: medium !important;
        }
        /*Termina aqui o style do Alert*/

        /* #GridUsuario {
            background-color: #fff;
            margin: 5px 0 10px 0;
            border: solid 1px #525252;
            border-collapse: collapse;
            font-family: Calibri;
            color: #474747;
        }*/

        .Grid td {
            padding: 2px;
            border: solid 1px #c1c1c1;
        }

        .Grid th {
            padding: 4px 2px;
            color: #fff;
            background: #363670 ;
            border-left: solid 1px #525252;
            font-size: 0.9em;
        }

        .Grid .alt {
            background: #fcfcfc;
        }

        .Grid .pgr {
            background: #363670 ;
        }

            .Grid .pgr table {
                margin: 3px 0;
            }

            .Grid .pgr td {
                border-width: 0;
                padding: 0 6px;
                border-left: solid 1px #666;
                font-weight: bold;
                color: #fff;
                line-height: 12px;
            }

            .Grid .pgr a {
                color: Gray;
                text-decoration: none;
            }

                .Grid .pgr a:hover {
                    color: #000;
                    text-decoration: none;
                }
    </style>



</head>

<body>

    <form id="form1" runat="server">
        <asp:HiddenField ID="nm_session" runat="server" />
        <asp:HiddenField ID="hdnId_usuario" runat="server" />
        <asp:HiddenField ID="hdnUsuario" runat="server" />
        <asp:HiddenField ID="hdnAcao" runat="server" />

        <div>
            <center>
                <table>
                    <tr>
                        <td>
                            <center>
                                <h3>Cadastrar Usuario</h3>
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
                        <td style="width: 500px;" class="input-group">
                            <div style="display: inline-block">
                                <asp:TextBox ID="txtSenha" Width="250px" placeholder="Senha" CssClass="form-control" name="password" type="Password" runat="server" AutoComplete="new-password"></asp:TextBox>
                                <input type="button" id="showPassword" style="height: 35px" value="Mostrar" class="btn btn-default" />
                                <input type="button" id="btnAlterarSenha" value="Alterar" visible="false" runat="server" class="btn btn-default" onclick="CarregarInf()" data-toggle="modal" data-target="#myModal" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnGravar" Text="Gravar" runat="server" CssClass="btn btn-success" OnClientClick="GravarUsuario()" />
                            <asp:Button ID="btnFiltrar" Text="Buscar" CssClass="btn btn-primary" runat="server" OnClick="btnFiltrar_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>


                <table>
                    <tr>
                        <td align="">
                            <asp:GridView ID="GridUsuario" CssClass="Grid" runat="server" AutoGenerateColumns="false" Width="600px"
                                AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt" PagerStyle-CssClass="pgr" HeaderStyle-HorizontalAlign="Center" OnPageIndexChanging="GridUsuario_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            Nome
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <span style="cursor: pointer;" onclick="nome( '<%# DataBinder.Eval(Container.DataItem, "id_usuario")%> ')" />
                                            <%# DataBinder.Eval(Container.DataItem, "ds_nome")%>
                                       </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="" DataField="usuario" HeaderText="usuario" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                </table>

            </center>
        </div>




        <div class="container">

            <!-- Modal -->
            <div class="modal fade" id="myModal" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Alterar Senha</h4>
                        </div>
                        <div class="modal-body">
                            <table>
                                <tr>
                                    <td style="height: 40px; width: 150px">Nome Completo:

                                    </td>
                                    <td style="text-align: left; height: 40px">

                                        <asp:TextBox ID="txtNomeModal" Width="350px" CssClass="form-control-css" runat="server"></asp:TextBox>

                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Usuario:
                                    </td>
                                    <td style="height: 40px">
                                        <asp:TextBox ID="txtUsuarioModal" CssClass="form-control-css" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Senha Atual:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtSenhaAtualModal" Width="140px" CssClass="form-control-css"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Nova Senha:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtNovaSenhaModal" Width="140px" CssClass="form-control-css"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="height: 40px">Confirmar Senha:
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="txtconfSenhaModal" Width="140px" CssClass="form-control-css" ControlToValidate="txtconfSenhaModal"></asp:TextBox>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Senhas são diferentes" ControlToCompare="txtNovaSenhaModal" ControlToValidate="txtconfSenhaModal"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</body>

</html>

