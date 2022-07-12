<script>

  import { active } from '../UrbitStore'
  import { onMount } from 'svelte'

  let scene = "share"

  function toClip() {
      const m = $active[0]
      const addr = "~" + m.author + "/" + m.slug
      navigator.clipboard.writeText(addr)  
    scene = "copied!"
    setTimeout(()=> scene = "share", 2000)
  }

</script>
{#if $active}
  <div class="title">
    {$active[0].title}
    <button on:click={toClip} class="addr">{scene}</button>
  </div>
  <div class="desc">
    {#each $active[0].description.split(/\r?\n/) as ln}
      <div class="line">{ln}</div>
    {/each}
  </div>
{/if}
<style>

  .title {
    margin: .6em 0 .6em 0;
    font-size: 2em;
    font-weight: 500;
    display: flex;
    align-content: center;
  }

  .addr {
    font-size: .3em;
    height: 2em;
    border: solid 1px #e9e9e9;
    background: white;
    border-radius: 4px;
    margin: 1.6em 0 0 1em;
  }

  .addr:hover {
    border-color: grey;
    background: grey;
    color: white;
  }

  .addr:active {
    border-color: black;
    background: black;
    color: white;
  }

  .desc {
    color: #666;
    font-size: .8em;
    padding-bottom: 2em;
    border-bottom: solid 1px #e9e9e9;
  }

  .line {
    padding-bottom: .6em; 
  }

</style>
