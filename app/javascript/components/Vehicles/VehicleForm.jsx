import React from 'react';
import { Formik, FieldArray, ErrorMessage, Field } from 'formik';
import * as Yup from 'yup';

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
  vehicleTypes
}) => {

  const handleSubmit = async (values) => {
    console.log(values);
  };

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
        nickname: vehicle.nickname,
        headline: vehicle.headline || '',
        vehicle_type_id: vehicle.vehicle_type_id,
      }}
      validationSchema={schema}
      onSubmit={handleSubmit}
    >
      {({ isSubmitting, values }) => (
        <form onSubmit={handleSubmit}>
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
        </form>
      )}
    </Formik>
  );
};

export default VehicleForm;
