import React, { useCallback } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';

import '../../lib/csrf-token';

const VehicleList = ({
  vehicles,
  navById,
  onRemove,
}) =>  {

  const handleDelete = useCallback(async (vehicle) => {
    try {
      await axios.delete(`/vehicles/${vehicle.id}`, { headers: { 'Content-Type': 'application/json' } });
      onRemove(vehicle);
    } catch (error) {
      console.log('axios error occurred');
      console.error(error);
    }
  }, [axios, onRemove]);

  return (<div>
    <h1>Vehicles</h1>

    <table>
      <thead>
        <tr>
          <th>Type</th>
          <th>Nickname</th>
          <th>Registration ID</th>
          <th colSpan="3"></th>
        </tr>
      </thead>
      <tbody>
        {vehicles.map((vehicle) => (
          <tr key={vehicle.id}>
            <td>{vehicle.vehicle_type.name}</td>
            <td>{vehicle.nickname}</td>
            <td>{vehicle.registration_id || 'pending'}</td>
            <td><Link to={`/vehicles/${vehicle.id}/edit`} onClick={() => { navById(vehicle.id) }}>Edit</Link></td>
            <td><button className="btn btn-secondary" onClick={() => { handleDelete(vehicle) }} type="button">Destroy</button></td>
          </tr>
        ))}
      </tbody>
    </table>
    <p style={{ marginTop: '1rem' }}>
      <Link to='/vehicles/new' onClick={() => { navById() }}>New Vehicle</Link>
    </p>
  </div>);
};
export default VehicleList;
