using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace GlucoseMonitor.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [EnableCors("AllowReactApp")] // Allow React app
    public class GlucoseController : ControllerBase
    {
        private static List<GlucoseReading> _readings = new();

        [HttpGet]
        public IActionResult GetGlucoseReadings()
        {
            return Ok(_readings);
        }

        [HttpPost]
        public IActionResult AddGlucoseReading([FromBody] GlucoseReading reading)
        {
            _readings.Add(reading);
            return Ok();
        }
    }

    public class GlucoseReading
    {
        public int Value { get; set; }
        public DateTime Timestamp { get; set; }
    }
}