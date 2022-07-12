<script>
  import { getDateRows, uuid, noop } from "./date-time.js";
  import { createEventDispatcher } from "svelte";

  const dispatch = createEventDispatcher();

  // props
  export let date;
  export let month;
  export let year;
  export let isAllowed;

  // local vars to help in render
  const weekdays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
  let cells;

  // function helpers
  const onChange = date => {
    dispatch("datechange", new Date(year, month, date));
  };

    const allow = (year, month, date) => {
        return true;
    /*
    if (!date) return true;
    return isAllowed(new Date(year, month, date));
    */
  };

  $: cells = getDateRows(month, year).map(c => ({
    value: c,
    allowed: allow(year, month, c)
  }));
</script>
<style>
  .container {
    width: 24em;
  }
  .row {
    display: flex;
    flex-wrap: wrap;
    gap: .3em;
    padding: .6em;
  }

  .cell {
    flex: 1 0 12%;
    display: inline-block;
    text-align: center;
    padding: .3em 0 .3em 0;
    border-radius: 4px;
  }

  .selected {
    background: black;
    color: white;
  }

  .disabled {
    background: #efefef;
    cursor: not-allowed;
    color: #bfbfbf;
  }

  .highlight:hover {
    background: grey;
    color: #fff;
    cursor: pointer;
  }

</style>

<div class="container">
  <div class="row">
    {#each weekdays as day}
      <div class="cell">{day}</div>
    {/each}
  </div>

  <div class="row">
    {#each cells as { allowed, value } (uuid())}
      <div
        on:click={allowed && value ? onChange.bind(this, value) : noop}
        class:cell={true}
        class:highlight={allowed && value}
        class:disabled={!allowed}
        class:selected={new Date(date.getFullYear(), date.getMonth(), date.getDate()).getTime() === new Date(year, month, value).getTime()}>
        {value || ''}
      </div>
    {/each}
  </div>
</div>
