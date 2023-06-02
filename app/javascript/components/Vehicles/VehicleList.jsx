import React from 'react';
import { Link } from 'react-router-dom';

const VehicleList = ({
  vehicles,
  navById,
}) =>  {
  return (<div>
    <h1>Vehicles</h1>

    <table>
      <thead>
        <tr>
          <th>Nickname</th>
          <th colSpan="3"></th>
        </tr>
      </thead>
      <tbody>
        {vehicles.map((vehicle) => (
          <tr key={vehicle.id}>
            <td>{vehicle.nickname}</td>
            <td><Link to={`/vehicles/${vehicle.id}/edit`} onClick={() => { navById(vehicle.id) }}>Edit</Link></td>
            <td><button type="button">Destroy</button></td>
          </tr>
        ))}
      </tbody>
    </table>
    <Link to='/vehicles/new' onClick={() => { navById() }}>New Vehicle</Link>
  </div>);
};
export default VehicleList;
