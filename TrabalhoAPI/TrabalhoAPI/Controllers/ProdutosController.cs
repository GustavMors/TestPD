using Microsoft.AspNetCore.Mvc;
using TrabalhoAPI.Repositories;
using TrabalhoAPI.Models;

namespace TrabalhoAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProdutosController : ControllerBase
    {
        private readonly ILogger<ProdutosController> _logger;
        public ProdutosController(ILogger<ProdutosController> logger)
        {
            _logger = logger;
        }
        [HttpGet]
        public ActionResult<List<Produto>> ListarProdutos()
        {
            return ProdutosRepository.ListarProdutos();
        }

        [HttpGet]
        [Route("ConsulatarProdutoCodBarras")]

        public ActionResult ConsulatarProdutoCodBarras(string codBarras)
        {
            var produto = ProdutosRepository.ConsulatarProdutoCodBarras( codBarras);
            if (produto.IdProduto == 0)
                return NotFound($"Não Foi Encontrado Resultado com o Codigo {codBarras}");
            return Ok(produto);
        }


        [HttpPost]
        public ActionResult NovoProduto(Produto produto)
        {
            int resultados = ProdutosRepository.NovoProduto(produto);
            return Ok($"{resultados} produtos cadastrados");
        }
    }
}
