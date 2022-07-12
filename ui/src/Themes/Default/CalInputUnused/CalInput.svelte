<script>
  import DatePicker from "./CalInput/DatePicker.svelte";
  import { active, editDraft } from '/src/UrbitStore'

  export let n, i

  let currentDate = new Date();
  let hour = 0
  let minute = 0
  let m = "AM"
  let q = $active[1][n].sec[i]
  const onDateChange = d => {
    currentDate = d.detail;
  }
</script>

<div class="container">
  {currentDate}
  <div class="selected">
    {#if q.x[0] === "datetime"}
      {currentDate.toDateString()}, {hour}:{minute} {m}
    {:else if q.x[0] === "time"}
      {hour}:{minute} {m}
    {:else if q.x[0] === "date"}
      {currentDate.toDateString()}
    {/if}
  </div>
  {#if (q.x[0] === "datetime") || (q.x[0] === "date")}
  <DatePicker
    on:datechange={onDateChange}
    selected={currentDate}
    isAllowed={true}
      />
  {/if}
  {#if (q.x[0] === "datetime") || (q.x[0] === "time")}
  <div class="time-picker">
    <input class="time" type="number" min=0 max=12 bind:value={hour}/>
    <span class="split">:</span>
    <input class="time" type="number" min=0 max=59 bind:value={minute}/>
    <span class="m">
      <button 
        on:click={()=> m = "AM"}
        class:active={m === "AM"}
      >
        AM
      </button>
      <button 
        on:click={()=> m = "PM"}
        class:active={m === "PM"}
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
