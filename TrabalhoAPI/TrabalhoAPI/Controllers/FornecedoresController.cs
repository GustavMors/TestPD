using Microsoft.AspNetCore.Mvc;
using TrabalhoAPI.Models;
using TrabalhoAPI.Repositories;

namespace TrabalhoAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class FornecedoresController : ControllerBase
    {
        private readonly ILogger<FornecedoresController> _logger;
        public FornecedoresController(ILogger<FornecedoresController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("ListarFornecedores")]

        public ActionResult<List<Fornecedor>> ListarFornecedores()
        {
            return FornecedoresRepository.ListarFornecedores();

        }
        ///
        [HttpGet]
        [Route("ConsulatarFornecedoresCNPJ")]

        public ActionResult ConsulatarFornecedoresCNPJ(string cnpj)
        {
            var fornecedor = FornecedoresRepository.ConsulatarFornecedoresCNPJ(cnpj);
            if (fornecedor.IdFornecedor == 0)
                return NotFound($"Não Foi Encontrado Resultado com o CNPJ : {cnpj}");
            return Ok(fornecedor);
        }

        //
        [HttpPost]
        [Route("CadastrarFornecedor")]
        public ActionResult CadastrarFornecedor(Fornecedor fornecedor)
        {
            int resultados = FornecedoresRepository.CadastrarFornecedor(fornecedor);
            return Ok($"{resultados} fornecedor cadastrado");
        }
    }
}
