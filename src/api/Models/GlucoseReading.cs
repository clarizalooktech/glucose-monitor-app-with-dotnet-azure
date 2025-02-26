using System;

namespace GlucoseMonitor.Models
{
    public class GlucoseReading
    {
        public int Id { get; set; }
        public DateTime Timestamp { get; set; }
        public double Value { get; set; }
    }
}