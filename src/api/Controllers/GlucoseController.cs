using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using GlucoseMonitor.Models;

namespace GlucoseMonitor.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class GlucoseController : ControllerBase
    {
        private static List<GlucoseReading> readings = new List<GlucoseReading>();

        [HttpGet]
        public ActionResult<IEnumerable<GlucoseReading>> GetReadings()
        {
            return Ok(readings);
        }

        [HttpPost]
        public ActionResult AddReading(GlucoseReading reading)
        {
            readings.Add(reading);
            return Ok();
        }
    }
}