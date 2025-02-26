import React, { useState, useEffect } from 'react';
import axios from 'axios';

const GlucoseReadings = () => {
  const [readings, setReadings] = useState([]);
  const [newReading, setNewReading] = useState({ value: '', timestamp: '' });

  useEffect(() => {
    axios.get('/api/glucose')
      .then(response => setReadings(response.data))
      .catch(error => console.error('Error fetching readings:', error));
  }, []);

  const handleAddReading = () => {
    axios.post('/api/glucose', newReading)
      .then(response => setReadings([...readings, response.data]))
      .catch(error => console.error('Error adding reading:', error));
  };

  return (
    <div>
      <h1>Glucose Readings</h1>
      <ul>
        {readings.map(reading => (
          <li key={reading.id}>{reading.value} at {new Date(reading.timestamp).toLocaleString()}</li>
        ))}
      </ul>
      <div>
        <input
          type="number"
          placeholder="Value"
          value={newReading.value}
          onChange={e => setNewReading({ ...newReading, value: e.target.value })}
        />
        <input
          type="datetime-local"
          placeholder="Timestamp"
          value={newReading.timestamp}
          onChange={e => setNewReading({ ...newReading, timestamp: e.target.value })}
        />
        <button onClick={handleAddReading}>Add Reading</button>
      </div>
    </div>
  );
};

export default GlucoseReadings;