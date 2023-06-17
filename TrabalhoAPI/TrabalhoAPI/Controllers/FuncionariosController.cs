using Microsoft.AspNetCore.Mvc;
using TrabalhoAPI.Models;
using TrabalhoAPI.Models.ViewModels;
using TrabalhoAPI.Repositories;

namespace TrabalhoAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FuncionariosController : ControllerBase
    {
        private readonly ILogger<FuncionariosController> _logger;
        public FuncionariosController(ILogger<FuncionariosController> logger)
        {
            _logger = logger;
        }



        [HttpPost]
        [Route("/logar")]
        public ActionResult LogarFuncionario([FromBody] UsuarioLogin usuario)
        {
            var funcionario = FuncionariosRepository.LogarFuncionario(usuario.Email, usuario.Senha);
            if (funcionario.Email == null)
                return NotFound($"usuário e/ou senha incorreto(s)");

            return Ok(funcionario);
        }

        [HttpGet]
        [Route("/Login")]

        public ActionResult ConsulatarLogin(string email, string senha)
        {
            var funcionario = FuncionariosRepository.ConsultarLogin(email, senha);
            if (funcionario.IdFuncionario == 0)
                return NotFound($"Usuário ou senha incorretos!");
            return Ok(funcionario);
        }

        [HttpGet]
        [Route("ListarFuncionarios")]
        public ActionResult <List<Funcionario>> ListarFuncionarios()
        {
            return FuncionariosRepository.ListarFuncionarios();

        }

        [HttpPost]
        public ActionResult CadastrarFuncionario(Funcionario funcionario)
        {
            int resultados = FuncionariosRepository.CadastrarFuncionario(funcionario);
            return Ok($"{resultados} funcionario cadastrado");
        }

        [HttpDelete]
        public ActionResult ExcluirFuncionario(string nome)
        {
            int resultado = FuncionariosRepository.ExcluirFuncionario(nome);
            return Ok($"Funcionario {nome} Excluido");
        }
        [HttpPut]
        [Route("AlterarSenha")]
        public ActionResult AlterarSenha(string email, string novasenha)
        {
            int resultado = FuncionariosRepository.AlterarSenha(email, novasenha);
            return Ok("Senha alterada!");
        }
        [HttpPut]
        [Route("AlterarUsuario")]
        public ActionResult AlterarUsuario(string novoEmail, string email, string setor, string senha, string nome)
        {
            int resultado = FuncionariosRepository.Alterarfuncionario(novoEmail,email, setor, senha, nome);
            return Ok("Funcionario Alterado!");
        }

    }
}
