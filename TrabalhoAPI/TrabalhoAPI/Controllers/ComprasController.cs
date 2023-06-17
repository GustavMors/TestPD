using Microsoft.AspNetCore.Mvc;
using TrabalhoAPI.Models;
using TrabalhoAPI.Models.ViewModels;
using TrabalhoAPI.Repositories;

namespace TrabalhoAPI.Controllers
{
    
    [ApiController]
    [Route("[controller]")]
    public class ComprasController : ControllerBase
    {
        private readonly ILogger<ComprasController> _logger;
        public ComprasController(ILogger<ComprasController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        [Route("ListarCompras")]
        public ActionResult<List<Compra>> ListarCompras()
        {
            return ComprasRepository.ListarCompras();

        }
        [HttpPost]
        [Route("CadastrarCompra")]
        public ActionResult CadastrarCompra(ComprasViewModel novacompra)
        {
            int resultados = ComprasRepository.CadastrarCompra(novacompra);
            return Ok($"{resultados} produtos cadastrados");
        }

    }
}
