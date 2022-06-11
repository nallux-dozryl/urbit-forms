<script>
  import { edit } from '../UrbitStore'

  export let survey;
  export let admin;

</script>
<div class="names">
  <div class=title>{survey[0].title}</div>
  <div class="description">{survey[0].description}</div>
  <div class="contact">~{survey[0].author}/{survey[0].slug}</div>
  <div class="panel">
    <div class="tab" on:click={()=> edit.set(false)}>Form</div>
    {#if survey[0].author === window.ship}
    <div class="tab" on:click={()=> edit.set(true)}>Edit</div>
    {/if}
  </div>
</div>
<style>

  .panel {
    display: flex;
    margin: auto;
    width: 60%;
  }

  .tab {
    flex: 1;
    padding: 1em .3em .3em .3em;
    text-align: center;
  }

  .names {
    text-align: center;
    margin-bottom: .6em;
    padding: .6em 0 0 0;
    border-bottom: 2px solid black;
  }

  .contact {
    font-size: 0.8em;
  }

  .title {
    font-size: 2.6em; 
  }

  .description {
    font-size: 1em;
    margin-bottom: 1em;
  }

</style>
