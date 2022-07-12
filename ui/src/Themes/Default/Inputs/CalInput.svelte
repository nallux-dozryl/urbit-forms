<script>

  import { active, editDraft } from '/src/UrbitStore'

  export let n, i

  let ndays

  let year = 2000
  let day = 1
  let month = 1

  let hour = 4
  let minute = 20
  let mer = "PM"

  let calendar = [
    {month: "January", days:31},  
    {month: "February", days:28}, 
    {month: "March", days:31}, 
    {month: "April", days:30}, 
    {month: "May", days:31},  
    {month: "June", days:30}, 
    {month: "July", days:31}, 
    {month: "August", days:31}, 
    {month: "September", days:30},  
    {month: "October", days:31}, 
    {month: "November", days:30}, 
    {month: "December", days:31}, 
  ]

    if ($active[2][n].sec[i].b.length > 0) {
      for (let k = 0; k < $active[2][n].sec[i].b.length; k++) {
          if ($active[2][n].sec[i].b[k].x === "year") {
            year = parseInt($active[2][n].sec[i].b[k].y)
          }
          if ($active[2][n].sec[i].b[k].x === "day") {
            day = $active[2][n].sec[i].b[k].y  
          }
          if ($active[2][n].sec[i].b[k].x === "month") {
            month = parseInt($active[2][n].sec[i].b[k].y)
          }
          if ($active[2][n].sec[i].b[k].x === "hour") {
            hour = $active[2][n].sec[i].b[k].y  
          }
          if ($active[2][n].sec[i].b[k].x === "minute") {
            minute = $active[2][n].sec[i].b[k].y  
          }
          if ($active[2][n].sec[i].b[k].x === "meridiem") {
            mer = $active[2][n].sec[i].b[k].y  
          }
      }  
      }

    function handleLeapYear() {
      if ((month == 2) && (year % 4 === 0)) {
        ndays = 29  
      } else {
        ndays = calendar[month - 1].days
      }
    }

  function handleClick(t) {
      let answer = []
      if (t === "time") {
          answer = [
            {x:'hour',y:hour.toString()},
            {x:'minute',y:minute.toString()},
            {x:'meridiem',y:mer}
          ]
      }
       if (t === "date") {
          answer = [
            {x:'year',y:year.toString()},
            {x:'month',y:month.toString()},
            {x:'day',y:day.toString()},
          ]
      }       
      if (t === "datetime") {
          answer = [
            {x:'year',y:year.toString()},
            {x:'month',y:month.toString()},
            {x:'day',y:day.toString()},
            {x:'hour',y:hour.toString()},
            {x:'minute',y:minute.toString()},
            {x:'meridiem',y:mer}
          ]
      }
      const data = {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid,
        head: "answer",
        accept: "grid",
        a:[],
        b:answer,
        c:[]
      }
      editDraft(data)  
    }

    handleLeapYear()

</script>

<div class="container">
  {#if ($active[1][n].sec[i].x[0] === "date") || ($active[1][n].sec[i].x[0] === "datetime")}
  <div class="date-picker">
    <div>
      <input
        class="day"
        type="number"
        min=1
        max={ndays}
        bind:value={day}
        on:blur={()=> handleClick($active[1][n].sec[i].x[0])}
        />
    </div>
    <div>
      <select
        class="month"
        bind:value={month}
        on:change={
        ()=> {handleLeapYear();
          handleClick($active[1][n].sec[i].x[0])
        }
        }>
        {#each calendar as c, i}
          <option value={i + 1}>{c.month}</option>
        {/each}
      </select>
    </div>
      <input
        class="year"
        type="number"
        min=0
        bind:value={year}
        on:blur={()=> handleClick($active[1][n].sec[i].x[0])}
      />
  </div>
  {/if}
  {#if ($active[1][n].sec[i].x[0] === "time") || ($active[1][n].sec[i].x[0] === "datetime")}
    <div class="time-picker">
      <input
        class="time"
        type="number"
        min=0 max=12
        bind:value={hour}
        on:blur={()=> handleClick($active[1][n].sec[i].x[0])}
      />
      <span class="split">:</span>
      <input
        class="time"
        type="number"
        min=0
        max=59
        bind:value={minute}
        on:blur={()=> handleClick($active[1][n].sec[i].x[0])}
      />
      <span class="m">
        <button 
          on:click={()=>{ mer = "AM"; handleClick($active[1][n].sec[i].x[0])}}
          class:active={mer === "AM"}
        >
          AM
        </button>
        <button 
          on:click={()=>{ mer = "PM"; handleClick($active[1][n].sec[i].x[0])}}
          class:active={mer === "PM"}
        >
          PM
        </button>
      </span>
    </div>
  {/if}
</div>

<style>

  .container {
    text-align: center;
  }

  .active {
    background: black;
    color: white;
    border-color: black;
  }

   .time-picker {
    width: 24em;
    margin: auto;
    margin-bottom: 2em;
    display: flex;
    align-items: center;
  }

  .date-picker {
    width: 36em;
    margin: auto;
    margin-bottom: 2em;
    display: flex;
    gap: .5em;
    align-items: center;
  }

  .year {
    width: 4em; 
    padding: .3em .3em .3em .6em;
  }

  .month {
    width: 8em;
    font-size: calc(2em - 1px);
    text-align: center;
    border-radius: 4px;
    background: #e9e9e9;
    border: none;
    padding: .3em;
  }

  .day {
    width: 4em;
    padding: .3em .3em .3em .6em;
  }

  .time {
    background: #e9e9e9;
    width: 3em;
    padding: .3em 0 .3em .5em;
  }

  .m {
    width: 7em;
    display: flex;
    margin-left: 1em;
    gap: .3em;
  }

  .split {
    width: .5em;
    font-size: 2em;
  }

  input[type="number"] {
    border: none;
    text-align: center;
    background: #e9e9e9;
    border-radius: 4px;
    font-size: 2em;
  }

  input:focus {
    outline: none;
  }

  button {
    background: white;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: 1.6em;
  }

  button:hover {
    color: white;
    background: grey;
    border-color: grey;
  }

  .selected {
    margin: auto;
    background: #e9e9e9;
    border-radius: 4px;
    width: 14em;
    text-align: center;
    padding: 1em;
    margin-bottom: 2em;
  }

</style>
