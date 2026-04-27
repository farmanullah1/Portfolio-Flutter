import React, { useState, useEffect } from 'react';
import './App.css';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import About from './components/About';
import Skills from './components/Skills';
import Certifications from './components/Certifications';
import Projects from './components/Projects';
import WhyMe from './components/WhyMe';
import Blog from './components/Blog';
import Contact from './components/Contact';
import Footer from './components/Footer';
import Experience from './components/Experience';
import ScrollProgress from './components/Scrollprogress';
import BackToTop from './components/Backtotop';

function App() {
  const [theme, setTheme] = useState('dark');
  const [activeSection, setActiveSection] = useState('home');

  useEffect(() => {
    document.body.className = theme;
  }, [theme]);

  // Track active section for nav highlight
  useEffect(() => {
    const sections = document.querySelectorAll('section[id], header[id]');
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            setActiveSection(entry.target.id);
          }
        });
      },
      { rootMargin: '-40% 0px -55% 0px' }
    );
    sections.forEach((s) => observer.observe(s));
    return () => observer.disconnect();
  }, []);

  const toggleTheme = () => setTheme((t) => (t === 'dark' ? 'light' : 'dark'));

  return (
    <div className="App">
      <ScrollProgress />
      <Navbar theme={theme} toggleTheme={toggleTheme} activeSection={activeSection} />
      <Hero />
      <About />
      <Skills />
      <Projects />
      <Experience />
      <Certifications />
      <WhyMe />
      <Blog />
      <Contact />
      <Footer />
      <BackToTop />
    </div>
  );
}

export default App;