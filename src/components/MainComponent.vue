<template>
  <div class="md:w-1/2 m-auto p-5 shadow-md bg-white rounded-md">
      <div class="grid grid-cols-2 gap-6">
          <div>
            <label>Maximum Number to use in exercise</label>
            <input class="h-10 text-lg border border-gray-500 rounded-md p-2 w-full" v-model="maxNumber">
          </div>
          <div>
            <label>How Many Exercises</label>
            <input class="h-10 text-lg border border-gray-500 rounded-md p-2 w-full" 
                    type="number" 
                    v-model="countExercises" 
                    min="0"
                    max="100"
                    @input="validateCountExercises">
          </div>
      </div>
      <div class="form-group flex flex-col mt-4">
            <div class="mb-4">What Operations to be Included</div>
            <div class="grid grid-cols-4 gap-4">
                <div>
                    <label for="sum">Sum (+) </label>
                    <input type="checkbox" id="sum" value="+" v-model="operations">
                </div>
                <div>
                    <label for="diff">Diff (-) </label>
                    <input type="checkbox" id="diff" value="-" v-model="operations">
                </div>
                <div>
                    <label for="multiply">Multiply (x) </label>
                    <input type="checkbox" id="multiply" value="x" v-model="operations">
                </div>
                <div>
                    <label for="divide">Divide (/) </label>
                    <input type="checkbox" id="divide" value="/" v-model="operations">
                </div>
            </div>
      </div>
      <div class="mt-6">
            <label for="showResult">Show Results </label>
            <input type="checkbox" id="showResult" v-model="showResult">
      </div>
      <div class="form-group flex flex-col">
          <button @click="createExercises" class="bg-red-500 rounded-md border-0 h-10 px-6 text-white m-auto mt-6">Generate {{countExercises > 1 ? countExercises + ' exercises' : countExercises + ' exercise'}}</button>
      </div>
  </div>
  <div class="mt-9 md:w-1/2 m-auto p-5" id="print">
      <div class="grid grid-cols-3 gap-4 text-xl">
            <div v-for="item, idx in exercises" :key="idx">
              {{ item.numberOne }} {{ item.operation }} {{ item.numberTwo }}  = {{ showResult ? item.result : null }}
            </div>
      </div>
  </div>
</template>

<script setup>
    import { ref } from 'vue'

    import { sum, diff, multiply, divide } from '../operations';

    const showResult = ref(false);
    const exercises = ref([])
    const countExercises = ref(12);
    const operationsSchema = {
        '+' : sum,
        '-' : diff,
        'x' : multiply,
        '/' : divide,
    }    

    const maxNumber = ref(10)
    const minNumber = 1
    const operations = ref(['+'])

    const randomNumber = () => {
        return Math.floor(Math.random() * (maxNumber.value - minNumber + 1) + minNumber)
    }

    const validateCountExercises = () => {
        if(countExercises.value < 0 || typeof countExercises.value != 'number') countExercises.value = 12
        if(countExercises.value > 100) countExercises.value = 100
    }

    const createExercises = () => {
        
        let i = 0;
        exercises.value = [];
        let maxEcercises = countExercises.value > 100 ? 100 : countExercises.value;

        while( i < maxEcercises) {
            let numberOne = 0, numberTwo = 0;
            
            let n1 = randomNumber();
            let n2 = randomNumber();
            let operation = operations.value[Math.floor(Math.random() * operations.value.length)];
                

            if(operation === '/') {
                if(n1 % n2 !== 0) {
                    while(n1 % n2 !== 0) {
                        n1 = randomNumber();
                        n2 = randomNumber();
                    }
                }
            }

            numberOne = n1
            numberTwo = n2
            
            if(['-','/'].includes(operation)) n1 < n2 ? (numberOne = n2, numberTwo = n1) : null
            
            const exercise = {
                numberOne, 
                operation,
                numberTwo,
                result : operationsSchema[operation](numberOne, numberTwo)
            }

            exercises.value.push(exercise)

            i++;
        }
        

    }

</script>