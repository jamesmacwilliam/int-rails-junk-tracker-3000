import React, { useCallback, useState } from 'react';
import { Formik, FieldArray, ErrorMessage, Field, Form } from 'formik';
import { Navigate } from 'react-router-dom';
import axios from 'axios';
import * as Yup from 'yup';

import '../../lib/csrf-token';

const FormInput = ({
  name,
  id,
  placeholder,
}) => (
    <Field
      role='input'
      id={id || name}
      name={name}
      placeholder={placeholder || `Enter a ${name}`}
      type='text'
    />
);

const FormItemWrapper = ({
  name,
  label,
  children,

}) => (
    <div className="field">
      <label htmlFor={name}>{label}</label>
        {children}
      <ErrorMessage style={{color: 'red' }} name={name} component='div' />
    </div>
);
const VehicleForm = ({
  vehicle,
  vehicleTypes,
  onSubmit,
}) => {
  const [submitSuccess, setSubmitSuccess] = useState(false);
  const handleSubmit = useCallback(async (values) => {
    let url = '/vehicles';
    let method = 'post';
    if (values.id) {
      method = 'put';
      url += `/${values.id}`;
    }
    const ax = axios[method];
    const headers = { 'Content-Type': 'application/json' };
    try {
      const { data } = await ax(url, { vehicle: values }, { headers,});
      onSubmit(data);
      setSubmitSuccess(true);
    } catch (error) {
      console.log('axios error occurred');
      console.error(error);
    }
  }, [axios, setSubmitSuccess]);

  const schema = Yup.object().shape({
    nickname: Yup.string().required('required'),
    vehicle_parts_attributes: Yup.array().of(Yup.object().shape({
      part_id: Yup.number().required('required'),
      part_status_id: Yup.number().required('required'),
    })),
  });

  return (
    <Formik
      initialValues={{
        id: vehicle.id,
        nickname: vehicle.nickname || '',
        headline: vehicle.headline || '',
        vehicle_type_id: vehicle.vehicle_type_id || vehicleTypes[0].id,
      }}
      validationSchema={schema}
      onSubmit={handleSubmit}
    >
      {({ isSubmitting, values }) => (
        <Form>
          {submitSuccess && (
            <Navigate to="/vehicles" replace={true} />
          )}
          <FormItemWrapper name='nickname' label='Nickname'>
            <FormInput name='nickname' />
          </FormItemWrapper>
          <FormItemWrapper name='headline' label='Headline'>
            <FormInput name='headline' />
          </FormItemWrapper>
          <FormItemWrapper name='vehicle_type_id' label='Type'>
            <Field as='select' name='vehicle_type_id'>
              {vehicleTypes.map((vType) => (
                <option key={vType.id} value={vType.id}>{vType.name}</option>
              ))}
            </Field>
          </FormItemWrapper>
          <button type="submit" disabled={isSubmitting}>Submit</button>
        </Form>
      )}
    </Formik>
  );
};

export default VehicleForm;
