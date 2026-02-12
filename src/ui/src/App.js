import React, { useState } from 'react';
import axios from 'axios';
import './App.css';

// Use environment variable for API URL, fallback to empty string for local proxy
const API_URL = process.env.REACT_APP_API_URL || '';

function App() {
    const [glucoseLevel, setGlucoseLevel] = useState('');
    const [measurementType, setMeasurementType] = useState('Fasting'); // Default to fasting

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await axios.post(`${API_URL}/api/glucose`, {
                level: parseInt(glucoseLevel),
                measurementType: measurementType,
                timestamp: new Date().toISOString()
            });
            alert('Glucose reading submitted!');
            setGlucoseLevel('');
        } catch (error) {
            console.error('Error submitting glucose reading:', error);
            alert('Failed to submit glucose reading.');
        }
    };

    const getGlucoseInterpretation = (level, type) => {
        if (type === 'Fasting') {
            if (level >= 80 && level <= 100) {
                return "Normal fasting glucose.";
            } else if (level >= 101 && level <= 125) {
                return "Impaired fasting glucose.";
            } else if (level >= 126) {
                return "Diabetic fasting glucose.";
            }
        } else if (type === 'Postprandial') {
            if (level >= 120 && level <= 140) {
                return "Normal postprandial glucose.";
            } else if (level > 140 && level < 200) {
                return "Impaired postprandial glucose.";
            } else if (level >= 200) {
                return "Diabetic postprandial glucose.";
            }
        }
        return "";
    };

    const interpretation = getGlucoseInterpretation(parseInt(glucoseLevel), measurementType);

    return (
        <div className="App">
            <h1>Glucose Monitor</h1>
            <form onSubmit={handleSubmit}>
                <label>
                    Glucose Level (mg/dL):
                    <input
                        type="number"
                        value={glucoseLevel}
                        onChange={(e) => setGlucoseLevel(e.target.value)}
                        required
                    />
                </label>
                <br />
                <label>
                    Measurement Type:
                    <select
                        value={measurementType}
                        onChange={(e) => setMeasurementType(e.target.value)}
                    >
                        <option value="Fasting">Fasting (12 hours)</option>
                        <option value="Postprandial">2-3 hours after meal</option>
                    </select>
                </label>
                <br />
                <button type="submit">Submit</button>
            </form>
            {interpretation && <p>{interpretation}</p>}
        </div>
    );
}

export default App;