<script>

  import NotAnswered from './NotAnswered.svelte'

  export let info, q

</script>

{#if (info.a[0] === undefined) || (info.a[0] === '')}
  <NotAnswered />
{:else}
  <div class="val">
    <input
      type="number"
      value={info.a[0]}
      disabled
    />
  </div>
  <div class="container">
    <div class="limit1">{q.min}</div>
    <div class="slider">
      <input 
        type="range" 
        step=0.0000001
        min={q.min}
        max={q.max}
        value={info.a[0]}
        disabled
      />
    </div>
    <div class="limit2">{q.max}</div>
  </div>
{/if}

<style>

  .val {
    text-align: center;
  }

  .container {
    display: flex;
    align-items: center;
    margin-bottom: 2em;
  }

  .limit1 {
    flex: 1;
    margin-right: 1em;
    text-align: right;
    font-size: .8em;
    color: #666;
    font-weight: 600;
    height: 2em;
  }

  .limit2 {
    flex: 1;
    margin-left: 1em;
    text-align: left;
    font-size: .8em;
    color: #666;
    font-weight: 600;
    height: 2em;

  }

  .slider {
    flex: 8;
    width: 100%;
  }

  input[type="number"] {
    padding: .6em 0 .6em 1.3em;
    background: #e9e9e9;
    border-radius: 4px;
    border: none;
    text-align: center;
    width: 8em;
  }

  input[type="number"]:focus {
    outline: none;
  }

  input[type=range] {
    appearance: none;
    width: 100%;
    background: transparent;
  }

  input[type=range]::-webkit-slider-thumb {
    appearance: none;
    height: 1.3em;
    width: 1.3em;
    border-radius: 50%;
    background: black;
    cursor: pointer;
    margin-top: -0.4em; /* Chrome */
  }

  input[type=range]::-moz-range-thumb {
    height: 1.3em;
    width: 1.3em;
    border-radius: 50%;
    background: black;
    cursor: pointer;
  }

  input[type=range]:focus {
    outline: none;
  }

  input[type=range]::-ms-track {
    width: 100%;
    cursor: pointer;
    background: transparent; 
    border-color: transparent;
    color: transparent;
  }
  input[type=range]::-webkit-slider-runnable-track {
  width: 100%;
  height: .6em;
  cursor: pointer;
  background: #e9e9e9;
  border-radius: 4px;
}

input[type=range]:focus::-webkit-slider-runnable-track {
  background: #e1e1e1;
}

input[type=range]::-moz-range-track {
  width: 100%;
  height: .6em;
  cursor: pointer;
  background: #e9e9e9;
  border-radius: 4px;
}

</style>
