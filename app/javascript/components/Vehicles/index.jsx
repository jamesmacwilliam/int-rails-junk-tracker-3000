import React, { useState, useCallback } from 'react';
import { BrowserRouter as Router, Route, Link, Routes, useHistory } from 'react-router-dom';

// custom
import VehicleList from './VehicleList';
import VehicleForm from './VehicleForm';

const Vehicles = ({
  vehicles: rawVehicles,
  vehicle: rawVehicle,
  vehicleTypes
}) => {

  // state
  const [vehicle, setVehicle] = useState(rawVehicle);
  const [vehicles, setVehicles] = useState(rawVehicles);

  // nav helper
  const navById = useCallback((id) => {
    setVehicle(vehicles.find((v) => v.id === id));
  }, [vehicles, setVehicle]);

  // manage vehicles
  const addVehicle = useCallback((attrs) => {
    setVehicles([attrs, ...vehicles]);
  }, [setVehicles, vehicles]);
  const getVehicleIndex = useCallback((attrs) => {
    return vehicles.findIndex((vAttrs) => attrs.id === vAttrs.id);
  }, [vehicles]);
  const removeVehicle = useCallback((attrs) => {
    let copy = JSON.parse(JSON.stringify(vehicles));
    copy.splice(getVehicleIndex(attrs), 1)
    setVehicles(copy);
  }, [setVehicles, getVehicleIndex]);
  const updateVehicle = useCallback((attrs) => {
    setVehicles([attrs, ...vehicles]);
    vehicles[getVehicleIndex(attrs)] = attrs;
    setVehicles(vehicles);
  }, [setVehicles, getVehicleIndex]);

  return(
    <Router>
      <div>
        <h1>Vehicle Management</h1>
        <Routes>
          <Route path="/"
            element={
              <VehicleList vehicles={vehicles} navById={navById} onRemove={removeVehicle} />
            }
          />
          <Route path="/vehicles"
            element={
              <VehicleList vehicles={vehicles} navById={navById} onRemove={removeVehicle} />
            }
          />
          <Route path="/vehicles/new"
            element={
              <VehicleForm vehicle={{}} vehicleTypes={vehicleTypes} onSubmit={addVehicle} />
            }
          />
          <Route path="/vehicles/:id/edit"
            element={
              <VehicleForm vehicle={vehicle} vehicleTypes={vehicleTypes} onSubmit={updateVehicle} />
            }
          />
        </Routes>
      </div>
    </Router>
  );
};

export default Vehicles;
