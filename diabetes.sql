
use diabetes;

select * from diabetes_prediction;

#### 1. Retrieve the Patient_id and ages of all patients.

select patient_id, age
from diabetes_prediction;


#### 2. Select all female patients who are older than 40

select patient_id
from diabetes_prediction
where  gender = 'Female' and age > 40;

#### 3. Calculate the average BMI of patients.

select round(avg(bmi), 2) as 'Average BMI of Patients'
from diabetes_prediction;

#### 4. List patients in descending order of blood glucose levels.

select * 
from diabetes_prediction
order by blood_glucose_level desc;

#### 5. Find patients who have hypertension and diabetes.

select employeename, patient_id 
from diabetes_prediction
where hypertension = 1 and diabetes = 1;

#### 6. Determine the number of patients with heart disease.

select count(*) as Patients_with_heart_disease
from diabetes_prediction
where heart_disease = 1;

#### 7. Group patients by smoking history and count how many smokers and non-smokers there are.

select if(grouping(smoking_history) , 'Total', smoking_history) as smoking_history, count(*) as Number_of_Patients
from diabetes_prediction
group by smoking_history
with rollup;

#### 8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.

select patient_id
from diabetes_prediction
where bmi > (select avg(bmi)
              from diabetes_prediction);
              
#### 9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
  

(select patient_id
from diabetes_prediction 
order by HbA1c_level desc
limit 1)

union all

(select patient_id 
from diabetes_prediction 
order by HbA1c_level asc
limit 1);


#### 10. Calculate the age of patients in years (assuming the current date as of now).

select patient_id, age, year(curdate()) - age as birth_year
from diabetes_prediction;


#### 11. Rank patients by blood glucose level within each gender group.


select patient_id, blood_glucose_level,
       rank() over (partition by gender order by blood_glucose_level) as Ranking
from diabetes_prediction;


#### 12. Update the smoking history of patients who are older than 50 to "Ex-smoker."

set sql_safe_updates = 0;

update diabetes_prediction 
set smoking_history = 'Ex-smoker'
where age > 50;

select * from diabetes_prediction;


#### 13. Insert a new patient into the database with sample data.


insert into diabetes_prediction (employeename, patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
values ('Danial vagun','PT9999','Male',40,0,1,'never',33.23,3,130,0);

#### 14. Delete all patients with heart disease from the database.

delete from diabetes_prediction 
where heart_disease = 1;

select * from diabetes_prediction;

#### 15. Find patients who have hypertension but not diabetes using the EXCEPT operator.

(select *
from diabetes_prediction
where hypertension = 1 and diabetes = 0)
except
(select * 
from diabetes_prediction
where diabetes = 1 and hypertension = 1);


#### 16. Define a unique constraint on the "patient_id" column to ensure its values are unique.

alter table diabetes_prediction
modify column patient_id varchar(50);

alter table diabetes_prediction
add constraint unique_patient_id
unique (patient_id);

desc diabetes_prediction;

####17. Create a view that displays the Patient_ids, ages, and BMI of patients.


create view patients as
select patient_id, age, bmi
from diabetes_prediction;

select * from patients;