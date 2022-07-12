<script>
  import { createEventDispatcher } from "svelte";
  import Calender from "./Calender.svelte";
  import { getMonthName } from "./date-time.js";

  const dispatch = createEventDispatcher();

  // props
  export let isAllowed = () => true;
  export let selected = new Date();

  // state
  let date, month, year, showDatePicker;

  // so that these change with props
  $: {
    date = selected.getDate();
    month = selected.getMonth();
    year = selected.getFullYear();
  }

  // handlers
//  const onFocus = () => {
//    showDatePicker = true;
//  };

  const next = () => {
    if (month === 11) {
      month = 0;
      year = year + 1;
      return;
    }
    month = month + 1;
  };

  const prev = () => {
    if (month === 0) {
      month = 11;
      year -= 1;
      return;
    }
    month -= 1;
  };

  const onDateChange = d => {
    showDatePicker = false;
    dispatch("datechange", d.detail);
  };
</script>

<style>

  .box {
    display: inline-block;
    background: #e9e9e9;
    border-radius: 4px;
    padding: 1em;
    margin-bottom: 2em;
  }

  .month-name {
    display: flex;
    justify-content: space-around;
    align-items: center;
    margin: 1em 0;
    font-size: .8em;
    font-weight: 500;
  }

  .center {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  button {
    background: black;
    border-radius: 4px;
    padding: .6em 2em .6em 2em;
    border: none;
    color: white;
    font-size: .8em;
    font-weight: 600;
  }

  button:hover {
    background: grey;
  }

  button:active {
    background: #e9e9e9;
    color: black;
  }
</style>

    <div class="box">
      <div class="month-name">
        <div class="center">
          <button on:click={prev}>Prev</button>
        </div>
        <div class="center">{getMonthName(month)} {year}</div>
        <div class="center">
          <button on:click={next}>Next</button>
        </div>
      </div>
      <Calender
        {month}
        {year}
        date={selected}
        {isAllowed}
        on:datechange={onDateChange} />
    </div>
