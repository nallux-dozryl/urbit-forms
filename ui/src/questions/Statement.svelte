<script>
  import { onMount } from 'svelte'

  export let edit = true;
  export let data;

  let title = "";
//    onMount(() => {
//        title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Urna condimentum mattis pellentesque id nibh tortor id aliquet. Ornare suspendisse sed nisi lacus sed viverra tellus in hac. Quis auctor elit sed vulputate mi sit. Vel eros donec ac odio tempor orci. Nisi est sit amet facilisis magna etiam.";
//      })


</script>
<div class="container">
  {#if edit === true}
    <textarea class="text" bind:value={title}></textarea>
  {:else}
    <span class="title">{title}</span>
  {/if}
</div>


<style>

  .container {
    min-height: 6em;
    margin: auto;
    width: 80%;
    border-bottom: 1px solid black;
  }

  .title {
    margin: 2em 0 2em 0;
  }

  .text {
    width: 100%;
    min-height: 9em;
    overflow: none;
  }

</style>
