import React, { useState, useCallback } from 'react';
import { BrowserRouter as Router, Route, Link, Routes, useHistory } from 'react-router-dom';

// custom
import VehicleList from './VehicleList';
import VehicleForm from './VehicleForm';

const Vehicles = ({
  vehicles,
  vehicle: rawVehicle,
  vehicleTypes
}) => {
  const [vehicle, setVehicle] = useState(rawVehicle);
  const navById = useCallback((id) => {
    setVehicle(vehicles.find((v) => v.id === id));
  }, [vehicles, setVehicle]);

  return(
    <Router>
      <div>
        <h1>Vehicle Management</h1>
        <Routes>
          <Route path="/vehicles"
            element={
              <VehicleList vehicles={vehicles} navById={navById} />
            }
          />
          <Route path="/vehicles/new"
            element={
              <VehicleForm vehicle={vehicle} vehicleTypes={vehicleTypes} />
            }
          />
          <Route path="/vehicles/:id/edit"
            element={
              <VehicleForm vehicle={vehicle} vehicleTypes={vehicleTypes} />
            }
          />
        </Routes>
      </div>
    </Router>
  );
};

export default Vehicles;
