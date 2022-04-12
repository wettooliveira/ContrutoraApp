<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cad_obra.aspx.cs" Inherits="cad_obra" %>

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

    <script type="text/javascript">

        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: 'btn btn-success',
                cancelButton: 'btn btn-danger'
            },
            buttonsStyling: false
        });

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
            else if (mensagem == ('Cancelar')) {
                var texto = ('Cancelado com Sucesso');
                var icon = ('success');
                /*var icon = ('error');*/
            }

            swalWithBootstrapButtons.fire({
                title: '',
                text: texto,
                icon: icon,
                confirmButtonText: 'OK',
                allowOutsideClick: false
            });
        }

        function Gravar() {


            var despesa = $('#txtNome').val();
            //var login = $('#txtUsuarioSenha').val();
            //var senha = $('#txtSenha').val();
            //var usuario = $('#hdnUsuario').val();

            $.ajax({
                type: "POST",
                url: "cad_obra.aspx/Gravar",
                /*data: "{'m':'m'}",*/
                data: "{'despesa':'" + despesa + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "JSON",
                success: function (data) {
                    var source = data.d;

                    if (source == 'OK') {
                        alertCss('Gravar');
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
        /*Termina aqui o style do Alert*
    </style>
</head>
<body runat="server">
    <asp:HiddenField ID="hdnUsuario" runat="server"/>
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
                            <br />
                            <center>
                                <input type="button" id="btnGravar" value="Gravar" runat="server" class="btn btn-success" onclick="Gravar()" />
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
